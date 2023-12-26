require 'haml'
require 'json'
require 'net/http'
require 'omniauth'
require 'omniauth-tumblr'
require 'ruby-bbcode'
require 'sinatra'
require 'tumblr_client'

require './comic'
require './post'
require './quip'
require './user'
require './models/node'
require './models/user_profile'

class App < Sinatra::Base
  use Rack::Session::Cookie, key: 'rack.session', secret: ENV['RACK_SESSION_SECRET']
  enable :logging

  use OmniAuth::Builder do
    provider :tumblr, ENV['TUMBLR_CONSUMER_KEY'], ENV['TUMBLR_CONSUMER_SECRET']
  end

  before do
    current_user
  end

  get '/about' do
    haml :about
  end

  get '/comics' do
    @comics = Comic.make
    haml :comics
  end

  get '/tracker' do
    if !params[:q].nil?
      @years = []

      revs = NodeRevision.all(:body.like => "%#{params[:q]}%")
      comments = Comment.all(:comment.like => "%#{params[:q]}%")

      @nodes = []

      revs.each do |r|
        @nodes << r.node
      end

      comments.each do |c|
        @nodes << c.node
      end
    else
      min = Time.at(Node.first.created).strftime('%Y')
      max = Time.at(Node.last.created).strftime('%Y')
      @years = (min.to_i..max.to_i).step(1)
      @nodes = []
    end

    @months = []

    haml :tracker
  end

  get '/tracker/:year' do
    @year = params[:year]
    @years = []
    @months = ('01'..'12')
    @nodes = []
    haml :tracker
  end

  get '/tracker/:year/:month' do
    @year = params[:year]
    @month = params[:month]

    year = @year.to_i
    month = @month.to_i

    pos = Date.new(year, month, 1).to_time.to_i

    if month == 12
      year += 12
      month = 1
    else
      month += 1
    end

    npos = Date.new(year, month, 1).to_time.to_i

    @nodes = Node.all(:created.gt => pos, :created.lt => npos)
    @years = []
    @months = []
    haml :tracker
  end

  get '/' do
    @posts = []

    Tumblr.configure do |config|
      config.consumer_key = ENV['TUMBLR_CONSUMER_KEY']
      config.consumer_secret = ENV['TUMBLR_CONSUMER_SECRET']
      config.oauth_token = ENV['TUMBLR_TOKEN']
      config.oauth_token_secret = ENV['TUMBLR_TOKEN_SECRET']
    end

    client = Tumblr::Client.new

    users = User.get_all

    users.each do |user|
      resp = client.posts("#{user}.tumblr.com")
      posts = resp['posts']

      next if posts.nil?

      posts.each do |p|
        @posts << Post.new(p)
      end
    end

    @posts.sort_by! { |p| p.date }
    @posts.reverse!

    haml :index
  end

  get '/nodes/:id' do
    node = Node.first(id: params[:id])
    created = Time.at(node.created)
    @year = created.year
    @month = created.month
    @node_rev = node.node_revisions.last unless node.nil?
    haml :node unless @node_rev.nil?
  end

  get '/~tgl' do
    haml :home, layout: false
  end

  get '/~tgl/italian-cookies' do
    haml :italian_cookies, layout: false
  end

  get '/~tgl/jeff-varasanos-ny-pizza-recipe' do
    haml :jeff_varasanos_ny_pizza_recipe, layout: false
  end

  get '/~tgl/kombucha' do
    haml :kombucha, layout: false
  end
  
  get '/~tgl/stuffed-quahog' do
    haml :stuffed_quahog, layout: false
  end

  get '/sitemap.xml' do
    haml :sitemap, layout: false
  end

  get '/auth/:provider/callback' do
    auth = auth_hash

    user = UserProfile.first_or_create({ uid: auth[:uid] }, {
                                         uid: auth[:uid],
                                         name: auth[:info][:name],
                                         provider: params[:provider],
                                         created_at: Time.now,
                                         updated_at: Time.now,
                                         access_token: auth[:credentials][:token],
                                         access_token_secret: auth[:credentials][:secret]
                                       })

    puts "user.uid #{user.uid}"

    session[:uid] = user.uid

    puts "session[:uid] #{session[:uid]}"

    puts "*** provider is #{params[:provider]}"

    if params[:provider] == 'tumblr'
      @blogs = []
      auth[:extra][:raw_info][:blogs].each do |b|
        @blogs << b[:name]
      end

      puts "$$$ blog size is #{@blogs.size}"

      if @blogs.size > 1
        haml :tumblr
      else
        redirect '/'
      end
    else
      redirect '/'
    end
  end

  post '/nodes' do
    if current_user
      Tumblr.configure do |config|
        config.consumer_key = ENV['TUMBLR_CONSUMER_KEY']
        config.consumer_secret = ENV['TUMBLR_CONSUMER_SECRET']
        config.oauth_token = @current_user.access_token
        config.oauth_token_secret = @current_user.access_token_secret
      end

      client = Tumblr::Client.new

      puts '***** made client'

      body_text = params[:body]

      timestamp = Time.now

      puts '**** Starting...'

      resp = client.text("#{@current_user.name}.tumblr.com", {
                           title: timestamp.strftime('%Y-%m-%d %H:%M'),
                           body: body_text,
                           tags: [params[:tag_names]]
                         })

      puts '**** Done.'
    else
      puts '**** Current User is nil!'
    end

    redirect '/'
  end

  post '/tumblr' do
    blogname = params[:blogname]

    puts "XXXX blogname is #{blogname}"
    puts 'XXXX anything else?'
    puts params

    user = UserProfile.get(current_user.id)

    puts "CCCC #{user.uid}"

    unless user.nil?
      user.uid = blogname
      user.name = blogname
      session[:uid] = blogname if user.save
    end

    redirect '/'
  end

  get '/auth/failure' do
    redirect '/'
  end

  get '/signout' do
    session[:uid] = nil
    redirect '/'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def current_user
    @current_user ||= UserProfile.first(uid: session[:uid]) if session[:uid]
  end

  def authenticate
    unless @current_user
      redirect '/'
      false
    end
  end
end
