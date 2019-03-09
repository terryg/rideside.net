require 'rubygems'
require 'haml'
require 'net/http'
require 'uri'

require 'dm-core'
require 'dm-types'
require 'dm-validations'
require 'dm-migrations'
require 'dm-timestamps'
require 'dm-redis-adapter'

DataMapper::Logger.new(STDOUT, :debug) 

DataMapper.setup(:default, (ENV['CLEARDB_DATABASE_URL'] || 'mysql://drupal:drupal@localhost/drupal'))

require './models/user_profile'
DataMapper.setup(:memstore, (ENV['REDISTOGO_URL'] || 'redis://localhost:6379'))
DataMapper.finalize

