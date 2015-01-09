require "rubygems"
require "haml"
require "net/http"
require "uri"

require "dm-core"
require "dm-types"
require "dm-validations"
require "dm-migrations"
require "dm-timestamps"

DataMapper::Logger.new(STDOUT, :debug)

configure :development do
    DataMapper.setup(:default, 'mysql://drupal:drupal@localhost/drupal')
end

configure :production do
    DataMapper.setup(:default, ENV['CLEARDB_DATABASE_URL'])
end

