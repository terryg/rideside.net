# frozen_string_literal: true

class SinatraApp
  # Handles top-level requests
  class ApplicationController
    get '/' do
      @posts = []

      client = Tumblr::Client.new

      users = User.all

      users.each do |user|
        resp = client.posts("#{user}.tumblr.com")
        posts = resp['posts']

        next if posts.nil?

        posts.each do |p|
          @posts << PostFactory.create(p)
        end
      end

      @posts.sort_by!(&:date)
      @posts.reverse!

      haml :index
    end

    get '/about' do
      haml :about
    end

    get '/comics' do
      @comics = Comic.make
      haml :comics
    end

    get '/auth/:provider/callback' do
      user =
        UserProfile
        .first_or_create({ uid: auth_hash[:uid] }, {
                           uid: auth_hash[:uid],
                           name: auth_hash[:info][:name],
                           provider: params[:provider],
                           created_at: Time.now,
                           updated_at: Time.now,
                           access_token: auth_hash[:credentials][:token],
                           access_token_secret: auth_hash[:credentials][:secret]
                         })
      session[:uid] = user.uid

      if params[:provider] == 'tumblr'
        @blogs = []
        auth_hash[:extra][:raw_info][:blogs].each do |b|
          @blogs << b[:name]
        end

        return haml :tumblr if @blogs.size > 1
      end

      redirect '/'
    end

    get '/auth/failure' do
      redirect '/'
    end

    post '/tumblr' do
      blogname = params[:blogname]

      user = UserProfile.get(current_user.id)

      unless user.nil?
        user.uid = blogname
        user.name = blogname
        session[:uid] = blogname if user.save
      end

      redirect '/'
    end

    get '/signout' do
      session[:uid] = nil
      redirect '/'
    end
  end
end
