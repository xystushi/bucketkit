# Bucketkit

BucketKit is a BitBucket REST API client that is heavily inspired by [Octokit](octokit.github.io).

## Installation

Add this line to your application's Gemfile:

    gem 'bucketkit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bucketkit

## Usage

### Authentication

You can use either basic authentication:

```ruby
c = Bucketkit::Client.new(login: 'foo', password: 'bar')
```

Or two legged OAuth:

```ruby
c = Bucketkit::Client.new do |c|
  c.login = 'foo'
  c.oauth_tokens = {
      {
          consumer_key:     'BUCKETKIT_CONSUMER_KEY',
          consumer_secret:  'BUCKETKIT_CONSUMER_SECRET',
          token:            'BUCKETKIT_TOKEN',
          token_secret:     'BUCKETKIT_TOKEN_SECRET'
      }
end
```

### Pull Requests

Get a list of pull requests:

    c.pull_requests('xystushi/bucketkit')
    
Get single pull request by id:

    c.pull_request('xystushi/bucketkit', 1)
    
Get commits on a pull request:

    c.pull_request_commits('xystushi/bucketkit', 1)
    
Get comments on a pull request:

    c.pull_request_comments('xystushi/bucketkit', 1)
    
Get the pull request activity:

    c.pull_request_activity('xystushi/bucketkit', 1)
    
Get the diff of a pull request:

    c.pull_request_diff('xystushi/bucketkit', 1)

Approve a pull request:

    c.approve_pull_request('xystushi/bucketkit', 1)
    
Delete a pull request approval:

    c.delete_pull_request_approval('xystushi/bucketkit', 1)
    
Merge a pull request:

    c.merge_pull_request('xystushi/bucketkit', 1)
    # or 
    c.accept_pull_request('xystushi/bucketkit', 1)
    
Decline a pull request:

    c.decline_pull_request('xystushi/bucketkit', 1)
    # or 
    c.reject_pull_request('xystushi/bucketkit', 1)

Create a pull request:

    c.create_pull_request('xystushi/bucketkit', 'title', 'some/fork', 'master',
        'this is a new pull request')

### Commits

Get a list of commits of a repository:

    c.commits('xystushi/bucketkit')
    
Get a single commit of a repository:

    c.commit('xystushi/bucketkit', 'abcdef123456')
    
Get comments on a commit:

    c.commit_comments('xystushi/bucketkit', 'abcdef123456')

Get a single comment on a commit by id:

    c.commit_comment('xystushi/bucketkit', 'abcdef123456', 1)
 
Approve a commit:

    c.approve_commit('xystushi/bucketkit', 'abcdef123456')
    
Delete a commit's approval:

    c.delete_commit_approval('xystushi/bucketkit', 'abcdef123456')
    
For more, please refer to [Bitbucket's API documentation](https://confluence.atlassian.com/display/BITBUCKET/Use+the+Bitbucket+REST+APIs)
## Contributing

1. Fork it ( http://github.com/xystushi/bucketkit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
