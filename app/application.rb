# frozen_string_literal: true

require 'haml'
require 'json'
require 'net/http'
require 'omniauth'
require 'omniauth-tumblr'
require 'ruby-bbcode'
require 'sinatra'
require 'tumblr_client'

# The top-level Sinatra-derived application
class SinatraApp < Sinatra::Base
  @@app = {} # rubocop:disable Style/ClassVars

  def self.new(*)
    self < SinatraApp ? super : Rack::URLMap.new(@@app)
  end

  def self.map(url)
    @@app[url] = self
  end

  use Rack::Session::Cookie, key: 'rack.session', secret: ENV['RACK_SESSION_SECRET']

  set :views, File.expand_path('views', __dir__)
  set :public_folder, File.expand_path('../public', __dir__)

  configure :production, :development do
    enable :logging
  end

  use OmniAuth::Builder do
    provider :tumblr, ENV['TUMBLR_CONSUMER_KEY'], ENV['TUMBLR_CONSUMER_SECRET']
  end

  before do
    current_user
  end

  class ApplicationController < SinatraApp
    map '/'
  end

  class NodesController < SinatraApp
    map '/nodes'
  end

  class ArchiveController < SinatraApp
    map '/archive'
  end

  class TglController < SinatraApp
    map '/~tgl'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def current_user
    @current_user ||= UserProfile.first(uid: session[:uid]) if session[:uid]
  end

  def authenticate
    return if @current_user

    redirect '/'
    false
  end
end
