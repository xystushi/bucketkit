module Bucketkit
  module Configurable
    attr_accessor :oauth_tokens,
                  :connection_options, :default_media_type,
                  :middleware, :proxy, :user_agent
    attr_writer :password, :login, :web_endpoint, :api_endpoint

    class << self
      def keys
        @keys ||= [
            :oauth_tokens,
            :api_endpoint,
            :web_endpoint,
            :login,
            :password,
            :connection_options,
            :default_media_type,
            :middleware,
            :user_agent
        ]
      end
    end

    def configure
      yield self
    end

    def reset!
      Bucketkit::Configurable.keys.each { |key|
        instance_variable_set(:"@#{key}", Bucketkit::Default.options[key])
      }
      self
    end
    alias setup reset!

    def api_endpoint
      File.join @api_endpoint, ''
    end

    def web_endpoint
      File.join @web_endpoint, ''
    end

    def login
      @login ||= begin
        user.login if basic_authenticated?
      end
    end

    private

    def options
      Hash[Bucketkit::Configurable.keys.map {|k| [k, instance_variable_get(:"@#{k}")]}]
    end
  end
end
