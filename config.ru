# bundler
require 'bundler'
Bundler.require

# basic auth
use Rack::Auth::Basic do |username, password|
  username == 'denis' && password == 'arsenal'
end

# datamapper init
DataMapper::setup(:default, ENV['DATABASE_URL'] || "mysql://root:i181MYSQL@localhost/doit")

# loader
require './loader.rb'

# datamaper finalize
DataMapper.finalize.auto_upgrade!

# maps and run
map('/')      { run Controllers::Main }
map('/note')  { run Controllers::Note }
map('/user')  { run Controllers::User }
