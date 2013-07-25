require File.join(File.dirname(__FILE__), 'base')

module Gritano
  module CLI
    module Console
      class Git < Base
        before %w{ git:receive:pack
                   git:upload:pack
                } do
          ActiveRecord::Base.establish_connection(YAML::load(File.open(Config.database_connection)))
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