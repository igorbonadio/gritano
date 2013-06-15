# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gritano"
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Igor Bonadio"]
  s.date = "2013-06-15"
  s.description = "Gritano is a tool to configure git servers over ssh"
  s.email = "igorbonadio@gmail.com"
  s.executables = ["gritano", "gritano-remote"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc",
    "TODO"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "Guardfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/gritano",
    "bin/gritano-remote",
    "gritano.gemspec",
    "lib/gritano.rb",
    "lib/gritano/config.rb",
    "lib/gritano/console/base.rb",
    "lib/gritano/console/git.rb",
    "lib/gritano/console/local.rb",
    "lib/gritano/console/remote.rb",
    "lib/gritano/core/key.rb",
    "lib/gritano/core/user.rb",
    "lib/gritano/helpers.rb",
    "lib/gritano/renderer.rb",
    "lib/gritano/thor.rb",
    "spec/data/development.yml",
    "spec/gritano/console/git_spec.rb",
    "spec/gritano/console/local_spec.rb",
    "spec/gritano/console/remote_spec.rb",
    "spec/gritano/core/key_spec.rb",
    "spec/gritano/core/user_spec.rb",
    "spec/gritano/helpers_spec.rb",
    "spec/gritano/thor_spec.rb",
    "spec/spec_helper.rb",
    "templates/local.gritano",
    "templates/remote.gritano"
  ]
  s.homepage = "http://github.com/igorbonadio/gritano"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Gritano is a tool to configure git servers over ssh"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thor>, ["~> 0.18.1"])
      s.add_runtime_dependency(%q<terminal-table>, ["~> 1.4.5"])
      s.add_runtime_dependency(%q<gritano-core>, ["~> 2.0.0"])
      s.add_runtime_dependency(%q<sqlite3>, ["~> 1.3.7"])
      s.add_development_dependency(%q<rspec>, ["~> 2.13.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.7.0"])
      s.add_development_dependency(%q<guard-rspec>, [">= 0"])
    else
      s.add_dependency(%q<thor>, ["~> 0.18.1"])
      s.add_dependency(%q<terminal-table>, ["~> 1.4.5"])
      s.add_dependency(%q<gritano-core>, ["~> 2.0.0"])
      s.add_dependency(%q<sqlite3>, ["~> 1.3.7"])
      s.add_dependency(%q<rspec>, ["~> 2.13.0"])
      s.add_dependency(%q<rdoc>, ["~> 4.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_dependency(%q<simplecov>, ["~> 0.7.0"])
      s.add_dependency(%q<guard-rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<thor>, ["~> 0.18.1"])
    s.add_dependency(%q<terminal-table>, ["~> 1.4.5"])
    s.add_dependency(%q<gritano-core>, ["~> 2.0.0"])
    s.add_dependency(%q<sqlite3>, ["~> 1.3.7"])
    s.add_dependency(%q<rspec>, ["~> 2.13.0"])
    s.add_dependency(%q<rdoc>, ["~> 4.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
    s.add_dependency(%q<simplecov>, ["~> 0.7.0"])
    s.add_dependency(%q<guard-rspec>, [">= 0"])
  end
end

