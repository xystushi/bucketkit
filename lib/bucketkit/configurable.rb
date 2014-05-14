module Bucketkit
  module Configurable
    attr_accessor :access_token, :client_id, :client_secret,
                  :connection_options, :default_media_type,
                  :middleware, :proxy, :user_agent
    attr_writer :password, :login, :web_endpoint, :api_endpoint

    class << self
      def keys
        @keys ||= [
            :access_token,
            :api_endpoint,
            :web_endpoint,
            :login,
            :password
        ]
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
          user.login if token_authenticated?
        end
      end

      private

      def options
        Hash[Bucketkit::Configurable.keys.map {|k| [k, instance_variable_get :"@#{k}"]}]
      end
    end
  end
end
