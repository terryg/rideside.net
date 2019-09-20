require 'rubygems'
require 'haml'
require 'net/http'
require 'uri'

require 'dm-core'
require 'dm-mysql-adapter'

require './models/user_profile'

DataMapper::Logger.new(STDOUT, :debug) 
DataMapper.setup(:default, (ENV['CLEARDB_DATABASE_URL'] || 'mysql://drupal:drupal@localhost/drupal'))
DataMapper.finalize

