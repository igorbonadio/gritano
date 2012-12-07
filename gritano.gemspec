# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gritano"
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Igor Bonadio"]
  s.date = "2012-12-07"
  s.description = "Gritano is the simplest way to configure your git server over ssh. You can create repositories and manage user access."
  s.email = "igorbonadio@gmail.com"
  s.executables = ["gritano", "gritano-check"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc",
    "TODO"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/gritano",
    "bin/gritano-check",
    "db/database.yml",
    "db/migrate/001_create_users.rb",
    "db/migrate/002_create_repositories.rb",
    "db/migrate/003_create_permissions.rb",
    "db/migrate/004_create_keys.rb",
    "db/migrate/005_add_admin_to_users.rb",
    "features/command.feature",
    "features/console.feature",
    "features/data/keys/full_authorized_keys",
    "features/data/keys/igorbonadio.pub",
    "features/data/keys/igorbonadio_authorized_keys",
    "features/data/keys/jessicaeto.pub",
    "features/data/keys/jessicaeto_authorized_keys",
    "features/keys.feature",
    "features/polices.feature",
    "features/step_definitions/command_step.rb",
    "features/step_definitions/console_step.rb",
    "features/step_definitions/keys_steps.rb",
    "features/step_definitions/polices_steps.rb",
    "features/support/database_cleaner.rb",
    "features/support/env.rb",
    "gritano.gemspec",
    "lib/gritano.rb",
    "lib/gritano/command.rb",
    "lib/gritano/console.rb",
    "lib/gritano/models.rb",
    "lib/gritano/models/key.rb",
    "lib/gritano/models/permission.rb",
    "lib/gritano/models/repository.rb",
    "lib/gritano/models/user.rb",
    "spec/command_spec.rb",
    "spec/console_spec.rb",
    "spec/model_key_spec.rb",
    "spec/model_repository_spec.rb",
    "spec/model_user_spec.rb",
    "spec/spec_helper.rb",
    "tmp/.gitignore"
  ]
  s.homepage = "http://github.com/igorbonadio/gritano"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Gritano is a tool to configure your git server over ssh"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 3.2.8"])
      s.add_runtime_dependency(%q<sqlite3>, [">= 1.3.6"])
      s.add_runtime_dependency(%q<grit>, [">= 2.5.0"])
      s.add_development_dependency(%q<rspec>, [">= 2.11.0"])
      s.add_development_dependency(%q<rdoc>, [">= 3.12"])
      s.add_development_dependency(%q<cucumber>, [">= 1.2.1"])
      s.add_development_dependency(%q<bundler>, [">= 1.0"])
      s.add_development_dependency(%q<jeweler>, [">= 1.8.4"])
      s.add_development_dependency(%q<simplecov>, [">= 0.6.4"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0.8.0"])
      s.add_development_dependency(%q<terminal-table>, [">= 1.4.5"])
    else
      s.add_dependency(%q<activerecord>, [">= 3.2.8"])
      s.add_dependency(%q<sqlite3>, [">= 1.3.6"])
      s.add_dependency(%q<grit>, [">= 2.5.0"])
      s.add_dependency(%q<rspec>, [">= 2.11.0"])
      s.add_dependency(%q<rdoc>, [">= 3.12"])
      s.add_dependency(%q<cucumber>, [">= 1.2.1"])
      s.add_dependency(%q<bundler>, [">= 1.0"])
      s.add_dependency(%q<jeweler>, [">= 1.8.4"])
      s.add_dependency(%q<simplecov>, [">= 0.6.4"])
      s.add_dependency(%q<database_cleaner>, [">= 0.8.0"])
      s.add_dependency(%q<terminal-table>, [">= 1.4.5"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 3.2.8"])
    s.add_dependency(%q<sqlite3>, [">= 1.3.6"])
    s.add_dependency(%q<grit>, [">= 2.5.0"])
    s.add_dependency(%q<rspec>, [">= 2.11.0"])
    s.add_dependency(%q<rdoc>, [">= 3.12"])
    s.add_dependency(%q<cucumber>, [">= 1.2.1"])
    s.add_dependency(%q<bundler>, [">= 1.0"])
    s.add_dependency(%q<jeweler>, [">= 1.8.4"])
    s.add_dependency(%q<simplecov>, [">= 0.6.4"])
    s.add_dependency(%q<database_cleaner>, [">= 0.8.0"])
    s.add_dependency(%q<terminal-table>, [">= 1.4.5"])
  end
end

