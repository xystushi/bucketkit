module Bucketkit
  class Client
    # See https://confluence.atlassian.com/display/BITBUCKET/commits+or+commit+Resource
    module Commits
      API_ENDPOINT = 'api/2.0/repositories'.freeze

      def commits(repo, options={})
        paginate "#{API_ENDPOINT}/#{Repository.new(repo)}/commits", options
      end

      def commit(repo, revision, options={})
        get "#{API_ENDPOINT}/#{Repository.new(repo)}/commit/#{revision}", options
      end

      def commit_comments(repo, revision, options={})
        get "#{API_ENDPOINT}/#{Repository.new(repo)}/commit/#{revision}/comments", options
      end

      def commit_comment(repo, revision, comment_id, options={})
        get "#{API_ENDPOINT}/#{Repository.new(repo)}/commit/#{revision}/comments/#{comment_id}", options
      end

      def approve_commit(repo, revision, options={})
        post "#{API_ENDPOINT}/#{Repository.new(repo)}/commit/#{revision}/approve", options
      end

      def delete_commit_approval(repo, revision, options={})
        delete "#{API_ENDPOINT}/#{Repository.new(repo)}/commit/#{revision}/approve", options
      end
    end
  end
end
