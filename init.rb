require "rubygems"
require "haml"
require "net/http"
require "uri"

require "dm-core"
require "dm-types"
require "dm-validations"
require "dm-migrations"
require "dm-timestamps"

DataMapper.setup(:default, (ENV['HEROKU_MYSQL_BLUE_URL'] || "mysql://drupal:drupal@localhost/drupal"))