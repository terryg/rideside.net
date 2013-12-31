require 'sinatra'
require 'haml'
require 'tumblr_client'
require 'json'

require './quip'
require './post'
require './user'
require './comic'

class App < Sinatra::Base
  
  Tumblr.configure do |config|
    config.consumer_key = ENV['TUMBLR_CONSUMER_KEY']
    config.consumer_secret = ENV['TUMBLR_CONSUMER_SECRET']
    config.oauth_token = ENV['TUMBLR_TOKEN']
    config.oauth_token_secret = ENV['TUMBLR_TOKEN_SECRET']
  end
  
  before do
    if request.env['HTTP_HOST'].match(/herokuapp\.com/)
      redirect 'http://www.rideside.net', 301
    end
  end

  get '/about' do
    haml :about
  end

  get '/comics' do
    @comics = Comic.make
    haml :comics
  end

  get '/tracker' do
    @posts = []
    haml :index
  end

  get '/' do
    @posts = []

    client = Tumblr::Client.new

    users = User.get_all

    users.each do |user|
      resp = client.posts("#{user}.tumblr.com")
      posts = resp['posts']
      
      posts.each do |p|
        @posts << Post.new(p)
      end unless posts.nil?
    end

    @posts.sort_by!{|p| p.date}
    @posts.reverse!

    haml :index
  end

  get '/~tgl' do
    haml :resume, :layout => false
  end

end
