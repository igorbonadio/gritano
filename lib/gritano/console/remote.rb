require File.join(File.dirname(__FILE__), 'base')

module Gritano
  module CLI
    module Console
      class Remote < Base
        before %w{ repo:list
                   key:list key:add key:rm

                   git:receive:pack
                   git:upload:pack
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

        define_task("git:receive:pack", "") do |repo_name|
          use_if_not_nil Gritano::Core::User.where(login: Config.remote_user).first do |user|
            repo = Gritano::Core::Repository.where(name: repo_name.gsub("'", "")).first
            Kernel.exec "git-receive-pack '#{repo.full_path}'" if user.check_access(repo, :write)
          end
        end

        define_task("git:upload:pack", "") do |repo_name|
          use_if_not_nil Gritano::Core::User.where(login: Config.remote_user).first do |user|
            repo = Gritano::Core::Repository.where(name: repo_name.gsub("'", "")).first
            Kernel.exec "git-upload-pack '#{repo.full_path}'" if user.check_access(repo, :read)
          end
        end
      end
    end
  end
end