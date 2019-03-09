class UserProfile
  include DataMapper::Resource
  def self.default_repository_name; :memstore end
  property :id, Serial
  property :uid, String
  property :name, String
  property :provider, String
  property :created_at, DateTime
  property :updated_at, DateTime
  property :access_token, String
  property :access_token_secret, String
end
