module Bucketkit
  module Authentication
    def basic_authenticated?
      !!(@login && @password)
    end

    def token_authenticated?
      !!@access_token
    end

    def user_authenticated?
      basic_authenticated? || token_authenticated?
    end
  end
end
