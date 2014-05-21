module Bucketkit
  module Authentication
    def basic_authenticated?
      !!(@login && @password)
    end

    def oauth_authenticated?
      !!@oauth_tokens
    end

    def user_authenticated?
      basic_authenticated? || oauth_authenticated?
    end
  end
end
