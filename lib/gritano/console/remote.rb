require File.join(File.dirname(__FILE__), 'base')

module Gritano
  module CLI
    module Console
      class Remote < Base

        def self.basename
          Gritano::CLI::Config.remote_ssh_prefix
        end

        before %w{ repo:list
                   key:list key:add key:rm
                } do
          ActiveRecord::Base.establish_connection(YAML::load(Config.database_connection))
        end
      
        define_task("repo:list", "list all repositories") do
          use_if_not_nil Gritano::Core::User.where(login: Config.remote_user).first do |user|
            render_table(user.repositories.order(:name), :name)
          end
        end

        define_task("key:list", "list all your keys") do
          use_if_not_nil Gritano::Core::User.where(login: Config.remote_user).first do |user|
            render_table(user.keys.order(:name), :name)
          end
        end

        define_task("key:add", "add a key") do |key_name|
          use_if_not_nil Gritano::Core::User.where(login: Config.remote_user).first do |user|
            create_model(user.keys, name: key_name, key: $stdin.readlines.join)
          end
        end

        define_task("key:rm", "remove a user's key") do |key_name|
          use_if_not_nil Gritano::Core::User.where(login: Config.remote_user).first do |user|
            destroy_model(user.keys, name: key_name)
          end
        end
      end
    end
  end
end