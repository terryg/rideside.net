require 'sinatra'
require 'haml'
require 'tumblr_client'
require 'json'
require 'net/http'

require './quip'
require './post'
require './user'
require './comic'
require './models/node'

Thread.new do 
  while true do
	  uri = URI('https://raw.githubusercontent.com/terryg/resume/master/README.md')
    response = Net::HTTP.get(uri)   
  
	  File.open('views/resume.haml', 'w') { |file| 
			file.write(".content\n")
			file.write("  :markdown\n")
			response.each_line { |line|
				file.write("    ")				
				file.write(line)
  		}	
		}

	  sleep(60.minutes)
  end
end

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
		min = Time.at(Node.first().created).strftime("%Y")
		max = Time.at(Node.last().created).strftime("%Y")

		@years = (min.to_i..max.to_i).step(1)

		@nodes = []

		haml :tracker
  end

	get '/tracker/:year' do
		@year = params[:year]
    @years = []
		@nodes = []
		haml :tracker
	end

	get '/tracker/:year/:month' do
		year = params[:year].to_i
		month = params[:month].to_i

		pos = Date.new(year, month, 1).to_time.to_i

    if month == 12
			year = year + 12
      month = 1
		else
			month = month + 1
		end

		npos = Date.new(year, month, 1).to_time.to_i

		@nodes = Node.all(:created.gt => pos, :created.lt => npos)
		@years = []
 
		haml :tracker
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

	get '/node/:id' do
		node = Node.first(:id => params[:id])
		@node_rev = node.node_revisions.last unless node.nil?
	  haml :node unless @node_rev.nil?  
	end

  get '/~tgl' do
    haml :resume, :layout => false
  end

end
