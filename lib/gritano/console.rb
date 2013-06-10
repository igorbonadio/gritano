module Gritano
  module CLI
    class Console < Thor

      extend Gritano::CLI::Renderer
      extend Gritano::CLI::Helpers

      define_task("user:list", "list all gritano users") do
        render_table(Gritano::Core::User.order(:login), :login, :admin)
      end

      define_task("user:add", "add a gritano user") do |login|
        create_model(Gritano::Core::User, login: login)
      end

      define_task("user:rm", "remove a gritano user") do |login|
        destroy_model(Gritano::Core::User, login: login)
      end

      define_task("user:key:list", "list all user's keys") do |login|
        use_if_not_nil Gritano::Core::User.where(login: login).first do |user|
          render_table(user.keys.order(:name), :name)
        end
      end

      define_task("user:key:add", "add a user's key") do |login, key_name|
        use_if_not_nil Gritano::Core::User.where(login: login).first do |user|
          create_model(user.keys, name: key_name, key: $stdin.readlines.join)
        end
      end

      define_task("user:key:rm", "remove a user's key") do |login, key_name|
        use_if_not_nil Gritano::Core::User.where(login: login).first do |user|
          destroy_model(user.keys, name: key_name)
        end
      end

      define_task("repo:list", "list all repositories") do
        render_table(Gritano::Core::Repository.order(:name), :name)
      end

      define_task("repo:add", "add a new repository") do |name|
        create_model(Gritano::Core::Repository, name: name, path: "tmp")
      end

      define_task("repo:rm", "remove a repository") do |name|
        destroy_model(Gritano::Core::Repository, name: name)
      end

      define_task("repo:read:add", "add read access to a repository") do |repo_name, user_login|
        use_if_not_nil Gritano::Core::User.where(login: user_login).first, Gritano::Core::Repository.where(name: repo_name).first do |user, repo|
          if user.add_access(repo, :read)
            render_text "done"
          else
            render_text "an error occurred"
          end
        end
      end

      define_task("repo:read:rm", "remove read access to a repository") do |repo_name, user_login|
        use_if_not_nil Gritano::Core::User.where(login: user_login).first, Gritano::Core::Repository.where(name: repo_name).first do |user, repo|
          if user.remove_access(repo, :read)
            render_text "done"
          else
            render_text "an error occurred"
          end
        end
      end

      define_task("repo:write:add", "add write access to a repository") do |repo_name, user_login|
        use_if_not_nil Gritano::Core::User.where(login: user_login).first, Gritano::Core::Repository.where(name: repo_name).first do |user, repo|
          if user.add_access(repo, :write)
            render_text "done"
          else
            render_text "an error occurred"
          end
        end
      end

      define_task("repo:write:rm", "remove write access to a repository") do |repo_name, user_login|
        use_if_not_nil Gritano::Core::User.where(login: user_login).first, Gritano::Core::Repository.where(name: repo_name).first do |user, repo|
          if user.remove_access(repo, :write)
            render_text "done"
          else
            render_text "an error occurred"
          end
        end
      end

      define_task("repo:user:list", "list all user that have access to a repository") do |repo_name|
        use_if_not_nil Gritano::Core::Repository.where(name: repo_name).first do |repo|
          render_table(repo.users.order(:login), :login, :access => repo)
        end
      end

    end
  end
end