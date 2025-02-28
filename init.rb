# frozen_string_literal: true

require 'rubygems'

require 'haml'
require 'net/http'
require 'rom'
require 'rom-sql'
require 'tumblr_client'

Dir.glob('./app/**/*.rb').sort.each do |f|
  require f
end

Tumblr.configure do |config|
  config.consumer_key = ENV['TUMBLR_CONSUMER_KEY']
  config.consumer_secret = ENV['TUMBLR_CONSUMER_SECRET']
  config.oauth_token = ENV['TUMBLR_TOKEN']
  config.oauth_token_secret = ENV['TUMBLR_TOKEN_SECRET']
end

configuration = ROM::Configuration.new(:sql, ENV['DATABASE_URL'])
configuration.register_relation(Comments, Nodes, NodeRevisions, Users)

MAIN_CONTAINER = ROM.container(configuration)
