require 'sinatra'
require 'haml'
require 'tumblr_client'
require 'json'

require './quip'

class App < Sinatra::Base
  
  Tumblr.configure do |config|
    config.consumer_key = ENV['TUMBLR_CONSUMER_KEY']
    config.consumer_secret = ENV['TUMBLR_CONSUMER_SECRET']
    config.oauth_token = ENV['TUMBLR_TOKEN']
    config.oauth_token_secret = ENV['TUMBLR_TOKEN_SECRET']
  end
  
  get '/' do
    @posts = []

    users = ['tlorber', 'michaeltfournier', 'thomasjwalshfrombillericama']
    client = Tumblr::Client.new

    users.each do |user|
      resp = client.posts("#{user}.tumblr.com")
      puts resp
      posts = resp['posts']
      
      posts.each do |p|
        @posts << p
      end unless posts.nil?
    end

    @posts.sort_by!{|p| p['date']}
    @posts.reverse!

    haml :index
  end

  get '/~tgl' do
    haml :resume
  end

end
