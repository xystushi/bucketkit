require 'sawyer'
require 'bucketkit/authentication'
require 'bucketkit/configurable'
require 'bucketkit/repository'
require 'bucketkit/client/pull_requests'
require 'bucketkit/client/commits'
require 'faraday_middleware'

module Bucketkit
  class Client
    include Bucketkit::Authentication
    include Bucketkit::Configurable
    include Bucketkit::Client::PullRequests
    include Bucketkit::Client::Commits

    CONVENIENCE_HEADERS = Set.new([:accept, :content_type])

    def initialize(options={})
      Bucketkit::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Bucketkit.instance_variable_get(:"@#{key}"))
      end
    end

    def same_options?(opts)
      opts.hash == options.hash
    end

    def get(url, options={})
      request :get, url, parse_query_and_convenience_headers(options)
    end

    def post(url, options={})
      request :post, url, options
    end

    def put(url, options={})
      request :put, url, options
    end

    def patch(url, options={})
      request :patch, url, options
    end

    def delete(url, options={})
      request :delete, url, options
    end

    def head(url, options={})
      request :head, url, parse_query_and_convenience_headers(options)
    end

    def paginate(url, options={}, &block)
      opts = parse_query_and_convenience_headers(options.dup)
      if @auto_paginate || @per_page
        opts[:query][:per_page] ||= @per_page || (@auto_paginate ? 100 : nil)
      end
      data = request(:get, url, opts)
      if @auto_paginate
        loop do
          break unless @last_response.rels[:next]
          @last_response = @last_response.rels[:next].get
          if block_given?
            yield(data, @last_response)
          else
            data.concat(@last_response.data) if @last_response.data.is_a?(Array)
          end
        end
      end
      data
    end

    def root
      get '/'
    end

    def last_response
      @last_response if defined? @last_response
    end

    def login=(value)
      reset_agent
      @login = value
    end

    def password=(value)
      reset_agent
      @password = value
    end

    def oauth_tokens=(value)
      reset_agent
      @oauth_tokens = value
    end

    def agent
      @agent ||= Sawyer::Agent.new(api_endpoint, sawyer_options) do |http|
        http.headers[:accept] = default_media_type
        http.headers[:content_type] = default_media_type
        http.headers[:user_agent] = user_agent
        if basic_authenticated?
          http.basic_auth(@login, @password)
        elsif oauth_authenticated?
          http.request :oauth, @oauth_tokens
        end
      end
    end

    private

    def reset_agent
      @agent = nil
    end

    def request(method, path, data, options={})
      if data.is_a? Hash
        options[:query] = data.delete(:query) || {}
        options[:headers] = data.delete(:headers) || {}
        accept = data.delete(:accept)
        options[:headers][:accept] = accept if accept
      end

      @last_response = response = agent.call(method, URI::Parser.new.escape(path.to_s), data, options)
      response.data
    end

    def boolean_from_response(method, path, options={})
      request method, path, options
      @last_response.status == 204
    end

    def sawyer_options
      opts = {
          links_parser: Sawyer::LinkParsers::Simple.new
      }
      conn_opts = @connection_options
      conn_opts[:builder] = @middleware if @middleware
      conn_opts[:proxy] = @proxy if @proxy
      opts[:faraday] = Faraday.new('https://api.bitbucket.org', conn_opts)

      opts
    end

    def parse_query_and_convenience_headers(options)
      headers = options.fetch(:headers, {})
      CONVENIENCE_HEADERS.each do |h|
        header = options.delete(h)
        headers[h] = header if header
      end
      query = options.delete(:query)
      opts = {query: options}
      opts[:query].merge!(query) if query && query.is_a?(Hash)
      opts[:headers] = headers unless headers.empty?

      opts
    end
  end
end
