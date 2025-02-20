require 'rubygems'
require 'haml'
require 'net/http'
require 'uri'

require 'dm-core'
require 'dm-mysql-adapter'
require 'tumblr_client'

require './models/user_profile'

Tumblr.configure do |config|
  config.consumer_key = ENV['TUMBLR_CONSUMER_KEY']
  config.consumer_secret = ENV['TUMBLR_CONSUMER_SECRET']
  config.oauth_token = ENV['TUMBLR_TOKEN']
  config.oauth_token_secret = ENV['TUMBLR_TOKEN_SECRET']
end

DataMapper::Logger.new(STDOUT, :debug) 
DataMapper.setup(:default, (ENV['CLEARDB_DATABASE_URL'] || 'mysql://drupal:drupal@localhost/drupal'))
DataMapper.finalize

