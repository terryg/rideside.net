# frozen_string_literal: true

class UserProfile
  attr_accessor :id, :uid, :name, :provider, :created_at, :updated_at, :access_token,
                :access_token_secret
end
