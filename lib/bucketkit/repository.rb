module Bucketkit
  class Repository
    attr_accessor :owner, :name

    def initialize(repo)
      case repo
        when String
          @owner, @name = repo.split('/')
        when Repository
          @owner, @name = repo.owner, repo.name
        when Hash
          @name = repo[:repo] ||= repo[:name]
          @owner = repo[:owner] ||= repo[:user] ||= repo[:username]
        else
          raise "Couldn't initialize repository."
      end
    end

    def self.from_url(url)
      Repository.new(URI.parse(url).path[1..-1])
    end

    def slug
      "#{@owner}/#{@name}"
    end
    alias :to_s :slug

    def url
      "#{Bucketkit.web_endpoint}#{slug}"
    end

    alias :user :owner
    alias :username :owner
    alias :repo :name
  end
end
