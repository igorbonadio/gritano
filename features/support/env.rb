require 'simplecov'
SimpleCov.start do
  add_filter "/features/"
  add_filter "/spec/"
end

require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'gritano'

require 'rspec/expectations'
require 'cucumber/rspec/doubles'

require 'active_record'

Before do
  ActiveRecord::Base.establish_connection(YAML::load(File.open('.gritano/database.yml')))
end
