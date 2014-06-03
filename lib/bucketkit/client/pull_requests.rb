module Bucketkit
  class Client
    module PullRequests
      API_ENDPOINT = 'api/2.0/repositories'.freeze
      def pull_requests(repo, options={})
        get "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests", options
      end

      def pull_request(repo, number, options={})
        get "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}", options
      end

      def pull_request_commits(repo, number, options={})
        get "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/commits", options
      end

      def pull_request_comments(repo, number, options={})
        get "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/comments", options
      end

      def pull_request_comment(repo, number, comment_id, options={})
        get "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/comments/#{comment_id}", options
      end

      def create_pull_request(repo, title, source, destination, options={})
        pull = {
            title: title,
            source: {
                branch: {
                    name: source
                }
            },
            destination: {
                branch: {
                    name: destination
                }
            }
        }
        post "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests", options.merge(pull)
      end

      def update_pull_request(repo, number, options)
        patch "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}", options
      end

      def approve_pull_request(repo, number)
        post "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/approve", nil
      end

      def delete_pull_request_approval(repo, number, options={})
        delete "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/approve", nil
      end

      def merge_pull_request(repo, number, options={})
        post "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/merge", options
      end

      def decline_pull_request(repo, number, options={})
        post "#{API_ENDPOINT}/#{Repository.new(repo)}/pullrequests/#{number}/decline", options
      end
      alias :reject_pull_request :decline_pull_request
    end
  end
end
