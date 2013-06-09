module Gritano
  module CLI
    class Console < Thor

      define_task("user:list", "list all gritano users") do
        users = Gritano::Core::User.order(:login)
        table = Terminal::Table.new do |t|
          t << ['login', 'admin?']
          t << :separator
          users.each do |user|
           t.add_row [user.login, user.admin]
          end
        end
        puts table
      end

      define_task("user:add", "add a gritano user") do |login|
        user = Gritano::Core::User.new(login: login)
        if user.save
          puts "user has been created successfully."
        else
          puts "an error occurred."
        end
      end

      define_task("user:rm", "remove a gritano user") do |login|
        user = Gritano::Core::User.where(login: login).first
        if user
          user.destroy
          puts "user destroyed."
        else
          puts "user doens't exist."
        end
      end

      method_option :admin, :aliases => "-a", :desc => "change admin status of a user"
      define_task("user:update", "update user information") do |login|
        user = Gritano::Core::User.where(login: login).first
        if user
          if options[:admin] == "true"
            user.admin = true
          elsif options[:admin] == "false"
            user.admin = false
          else
            puts "invalid admin parameter"
            return
          end
          if user.save
            puts "done"
          else
            puts "an error occurred"
          end
        else
          puts "user doens't exist."
        end
      end

      define_task("user:key:list", "list all user's keys") do |login|
        user = Gritano::Core::User.where(login: login).first
        if user
          if user.keys.count > 0
            table = Terminal::Table.new do |t|
              t << ['name']
              t << :separator
              user.keys.each do |key|
               t.add_row [key.name]
              end
            end
            puts table
          else
            puts "user doesn't have keys"
          end
        else
          puts "user doens't exist."
        end
      end

      define_task("user:key:add", "add a user's key") do |login, key_name|
        user = Gritano::Core::User.where(login: login).first
        if user
          key = user.keys.new(name: key_name, key: $stdin.readlines.join)
          if key.save
            puts "key added."
          else
            puts "an error occurred."
          end
        else
          puts "user doens't exist."
        end
      end

      define_task("user:key:rm", "remove a user's key") do |login, key_name|
        user = Gritano::Core::User.where(login: login).first
        if user
          key = user.keys.where(name: key_name).first
          if key
            key.destroy
            puts "key was destroyed."
          else
            puts "an error occurred."
          end
        else
          puts "user doens't exist."
        end
      end

      define_task("repo:list", "list all repositories") do
        repos = Gritano::Core::Repository.all.order(:name)
        table = Terminal::Table.new do |t|
          t << ['name']
          t << :separator
          repos.each do |repo|
           t.add_row [repo.name]
          end
        end
        puts table
      end

      define_task("repo:add", "add a new repository") do |name|
        repo = Gritano::Core::Repository.new(name: name, path: "tmp")
        if repo.save
          puts "repository has been created successfully."
        else
          puts "an error occurred."
        end
      end

      define_task("repo:rm", "remove a repository") do |name|
        repo = Gritano::Core::Repository.where(name: name).first
        if repo
          repo.destroy
          puts "repo destroyed."
        else
          puts "repo doens't exist."
        end
      end

      define_task("repo:read:add", "add read access to a repository") do |repo_name, user_login|
        repo = Gritano::Core::Repository.where(name: repo_name).first
        user = Gritano::Core::User.where(login: user_login).first
        if repo and user
          if user.add_access(repo, :read)
            puts "done"
          else
            puts "an error occurred"
          end
        else
          puts "repository or user doens't exist."
        end
      end

      define_task("repo:read:rm", "remove read access to a repository") do |repo_name, user_login|
        repo = Gritano::Core::Repository.where(name: repo_name).first
        user = Gritano::Core::User.where(login: user_login).first
        if repo and user
          if user.remove_access(repo, :read)
            puts "done"
          else
            puts "an error occurred"
          end
        else
          puts "repository or user doens't exist."
        end
      end

      define_task("repo:write:add", "add write access to a repository") do |repo_name, user_login|
        repo = Gritano::Core::Repository.where(name: repo_name).first
        user = Gritano::Core::User.where(login: user_login).first
        if repo and user
          if user.add_access(repo, :write)
            puts "done"
          else
            puts "an error occurred"
          end
        else
          puts "repository or user doens't exist."
        end
      end

      define_task("repo:write:rm", "remove write access to a repository") do |repo_name, user_login|
        repo = Gritano::Core::Repository.where(name: repo_name).first
        user = Gritano::Core::User.where(login: user_login).first
        if repo and user
          if user.remove_access(repo, :write)
            puts "done"
          else
            puts "an error occurred"
          end
        else
          puts "repository or user doens't exist."
        end
      end

      define_task("repo:user:list", "list all user that have access to a repository") do |repo_name|
        repo = Gritano::Core::Repository.where(name: repo_name).first
        if repo
          table = Terminal::Table.new do |t|
            t << ['login', 'access']
            t << :separator
            repo.users.each do |user|
              access = []
              access << 'read' if user.check_access(repo, :read)
              access << 'write' if user.check_access(repo, :write)
             t.add_row [user.login, "#{access.join('+')}"]
            end
          end
          puts table
        else
          puts "repo doens't exist."
        end
      end

    end
  end
end