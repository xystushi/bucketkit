module Bucketkit
  class Client
    module PullRequests
      def pull_requests(repo, options={})
        get "api/2.0/repositories/#{Repository.new(repo)}/pullrequests", options
      end

      def pull_request(repo, number, options={})

      end

      def create_pull_request(repo, base, head, title, body, options={})

      end
    end
  end
end
