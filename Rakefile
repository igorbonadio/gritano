# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "gritano"
  gem.homepage = "http://gritano.org"
  gem.license = "MIT"
  gem.summary = %Q{Gritano is a tool to configure git servers over ssh}
  gem.description = %Q{Gritano is a tool to configure git servers over ssh}
  gem.email = "igorbonadio@gmail.com"
  gem.authors = ["Igor Bonadio"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "gritano #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'gritano-core'
namespace :db do
  desc "Migrate the database. Target specific version with VERSION=x"
  task :migrate do
    FileUtils.mkdir 'tmp' unless File.exist? 'tmp'
    Gritano::Core::Migration.migrate(YAML::load(File.open('spec/data/development.yml')))
  end
end
