module Bucketkit
  class Client
    # See https://confluence.atlassian.com/display/BITBUCKET/pullrequests+Resource
    module PullRequests
      API_ENDPOINT = 'api/2.0/repositories'.freeze

      def pull_requests(repo, options={})
        get "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests", options
      end

      def create_pull_request(repo, title, source, destination='master', options={})
        pull = {
            title: title,
            source: { branch: { name: source } },
            destination: { branch: { name: destination } }
        }
        post "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests", options.merge(pull)
      end

      def update_pull_request(repo, number, options)
        patch "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}", options
      end

      def pull_request(repo, number, options={})
        get "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}", options
      end

      def pull_request_commits(repo, number, options={})
        get "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/commits", options
      end

      def approve_pull_request(repo, number, options={})
        post "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/approve", options
      end

      def delete_pull_request_approval(repo, number, options={})
        delete "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/approve", options
      end

      def pull_request_diff(repo, number, options={})
        get "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/diff", options
      end

      def pull_request_activity(repo, number=nil, options={})
        get "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/activity", options
      end

      def merge_pull_request(repo, number, options={})
        post "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/merge", options
      end
      alias :accept_pull_request :merge_pull_request

      def decline_pull_request(repo, number, options={})
        post "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/decline", options
      end
      alias :reject_pull_request :decline_pull_request

      def pull_request_comments(repo, number, options={})
        get "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/comments", options
      end

      def pull_request_comment(repo, number, comment_id, options={})
        get "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/comments/#{comment_id}", options
      end
    end
  end
end
