module Bucketkit
  module Default
    WEB_ENDPOINT = 'https://bitbucket.org'.freeze

    class << self
      def options
        Hash[Bucketkit::Configurable.keys.map { |k| [k, send(k)]}]
      end

      def web_endpoint
        ENV['BUCKETKIT_WEB_ENDPOINT'] || WEB_ENDPOINT
      end
    end
  end
end
