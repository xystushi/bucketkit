require 'bucketkit/client'
require 'bucketkit/default'

module Bucketkit
  class << self
    include Bucketkit::Configurable

    def client
      @client = Bucketkit::Client.new(options) unless defined?(@client) && @client.same_options?(options)
      @client
    end

    private

    def method_missing(method, *args, &block)
      return super unless client.respond_to?(method)
      client.send(method, *args, &block)
    end
  end
end

Bucketkit.setup
