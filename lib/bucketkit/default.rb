require 'bucketkit/version'
require 'faraday_middleware'

module Bucketkit
  module Default
    WEB_ENDPOINT = 'https://bitbucket.org'.freeze
    API_ENDPOINT = 'https://bitbucket.org'.freeze
    USER_AGENT = "Bucketkit Ruby Gem #{Bucketkit::VERSION}".freeze
    MEDIA_TYPE = 'application/json'.freeze

    class << self
      def options
        Hash[Bucketkit::Configurable.keys.map { |k| [k, send(k)]}]
      end

      def web_endpoint
        ENV['BUCKETKIT_WEB_ENDPOINT'] || WEB_ENDPOINT
      end

      def api_endpoint
        ENV['BUCKETKIT_API_ENDPOINT'] || API_ENDPOINT
      end

      def oauth_tokens
        {
            consumer_key: ENV['BUCKETKIT_CONSUMER_KEY'],
            consumer_secret: ENV['BUCKETKIT_CONSUMER_SECRET'],
            token: ENV['BUCKETKIT_TOKEN'],
            token_secret: ENV['BUCKETKIT_TOKEN_SECRET']
        }
      end

      def login
        ENV['BUCKETKIT_LOGIN']
      end

      def password
        ENV['BUCKETKIT_PASSWORD']
      end

      def connection_options
        {
            headers: {
                content_type: default_media_type,
                accept: default_media_type,
                user_agent: user_agent
            }
        }
      end

      def default_media_type
        ENV['BUCKETKIT_DEFAULT_MEDIA_TYPE'] || MEDIA_TYPE
      end

      def user_agent
        ENV['BUCKETKIT_USER_AGENT'] || USER_AGENT
      end

      def middleware
        Faraday::RackBuilder.new do |builder|
          builder.request :oauth, oauth_tokens
          builder.adapter Faraday.default_adapter
        end
      end
    end
  end
end
