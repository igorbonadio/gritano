require "terminal-table"

module Gritano
  module Console
    class Executor < Gritano::Console::Base
      attr_accessor :repo_path
      attr_accessor :ssh_path

      def initialize(stdin)
        @repo_path = Etc.getpwuid.dir
        @ssh_path = File.join(Etc.getpwuid.dir, '.ssh')
        @stdin = stdin
      end

      before_each_command do
        check_git
        check_gritano
        ActiveRecord::Base.establish_connection(
          YAML::load(File.open(File.join(Etc.getpwuid.dir, '.gritano', 'database.yml'))))
      end
    
      add_command "user:list" do |argv|
        users = User.all
        msg = Terminal::Table.new do |t|
          t << ['user']
          t << :separator
          users.each do |user|
            t.add_row [user.login]
          end
        end
        msg = "there is no user registered" if users.count == 0
        return [true, msg]
      end

      add_command "user:key:list", "username" do |argv|
        login, = argv
        user = User.find_by_login(login)
        if user
          keys = user.keys
          msg = Terminal::Table.new do |t|
            t << ['keys']
            t << :separator
            keys.each do |key|
              t.add_row [key.name]
            end
          end
          msg = "there is no key registered" if keys.count == 0
          return [true, msg]
        else
          return [false, "User #{login} is not registered"]
        end
      end

      add_command "user:repo:list", "username" do |argv|
        login, = argv
        user = User.find_by_login(login)
        if user
          repos = user.repositories
          msg = Terminal::Table.new do |t|
            t << ['repositories']
            t << :separator
            repos.each do |repo|
              t.add_row [repo.name]
            end
          end
          msg = "there is no repository registered" if repos.count == 0
          return [true, msg]
        else
          return [false, "User #{login} is not registered"]
        end
      end

      add_command "user:add", "username" do |argv|
        login, = argv
        user = User.new(login: login)
        return [true, "User #{login} added."] if user.save
        return [false, "#{user.errors.full_messages.join(", ")}."]
      end

      add_command "user:rm", "username" do |argv|
        login, = argv
        user = User.find_by_login(login)
        if user
          if user.destroy
            return [true, "User #{login} removed."] 
          end
        end
        return [false, "User #{login} could not be removed."]
      end

      add_command "user:key:add", "username keyname < key.pub" do |argv|
        login, key_name, key_file = argv
        user = User.find_by_login(login)
        if user
          key = user.keys.create(name: key_name, key: @stdin.read)
          if key.valid?
            File.open(File.join(@ssh_path, 'authorized_keys'), 'w').write(Key.authorized_keys)
              return [true, "Key added successfully."]
          end
        end
        return [false, "Key could not be added."]
      end

      add_command "user:key:rm", "username keyname" do |argv|
        login, key_name = argv
        key = Key.where(name: key_name).includes(:user).where("users.login" => login).limit(1)[0]
        if key
          if key.destroy
            File.open(File.join(@ssh_path, 'authorized_keys'), 'w').write(Key.authorized_keys)
            return [true, "Key removed successfully."]
          end
        end
        return [false, "Key could not be removed."]
      end

      add_command "user:admin:add", "username" do |argv|
        login, = argv
        user = User.find_by_login(login)
        if user
          user.admin = true
          if user.save
            return [true, "Now, user #{login} is an administrator"]
          end
        end
        return [false, "User #{login} could not be modified"]
      end

      add_command "user:admin:rm", "username" do |argv|
        login, = argv
        user = User.find_by_login(login)
        if user
          user.admin = false
          if user.save
            return [true, "Now, user #{login} is not an administrator"]
          end
        end
        return [false, "User #{login} could not be modified"]
      end

      add_command "repo:list" do |argv|
        repos = Repository.all
        msg = Terminal::Table.new do |t|
          t << ['repositories']
          t << :separator
          repos.each do |repo|
            t.add_row [repo.name]
          end
        end
        msg = "there is no repository registered" if repos.count == 0
        return [true, msg]
      end

      add_command "repo:add", "reponame.git [username1 username2 ...]*" do |argv|
        name, user_login = argv
        repo = Repository.new(name: name, path: @repo_path)
        if repo.save
          if user_login
            argv[1..-1].each do |login|
              user = User.find_by_login(login)
              if user
                user.add_access(repo, :read)
                user.add_access(repo, :write)
              end
            end
          end
          return [true, "Repository #{name} created successfully."]
        end
        return [false, "Repository #{name} could not be created."]
      end

      add_command "repo:user:list", "reponame.git" do |argv|
        name, = argv
        repo = Repository.find_by_name(name)
        if repo
          users = repo.users
          msg = Terminal::Table.new do |t|
            t << ['user', 'permission']
            t << :separator
            users.each do |user|
              permissions = ""
              user.permissions.find_by_repository_id(repo.id) do |p|
                permissions += "r" if p.is(:read)
                permissions += "w" if p.is(:write)
              end
              t.add_row [user.login, permissions]
            end
          end
          msg = "No user have access to this repository" if users.count == 0
          return [true, msg]
        end
        return [false, "Repository #{name} doesn't exist."]
      end

      add_command "repo:rm", "reponame.git" do |argv|
        name, = argv
        repo = Repository.find_by_name(name)
        if repo
          if repo.destroy
            return [true, "Repository #{name} removed successfully."]
          end
        end
        return [false, "Repository #{name} could not be removed."]
      end

      add_command "repo:read:add", "reponame.git username" do |argv|
        repo_name, login = argv
        user = User.find_by_login(login)
        repo = Repository.find_by_name(repo_name)
        if repo and user
          return [true, "User #{login} has read access to #{repo_name}."] if user.add_access(repo, :read)
        end
        return [false, "An error occurred. Permissions was not modified."]
      end

      add_command "repo:write:add", "reponame.git username" do |argv|
        repo_name, login = argv
        user = User.find_by_login(login)
        repo = Repository.find_by_name(repo_name)
        if repo and user
          return [true, "User #{login} has write access to #{repo_name}."] if user.add_access(repo, :write)
        end
        return [false, "An error occurred. Permissions was not modified."]
      end

      add_command "repo:read:rm", "reponame.git username" do |argv|
        repo_name, login = argv
        user = User.find_by_login(login)
        repo = Repository.find_by_name(repo_name)
        if repo and user
          return [true, "User #{login} has not read access to #{repo_name}."] if user.remove_access(repo, :read)
        end
        return [false, "An error occurred. Permissions was not modified."]
      end

      add_command "repo:write:rm", "reponame.git username" do |argv|
        repo_name, login = argv
        user = User.find_by_login(login)
        repo = Repository.find_by_name(repo_name)
        if repo and user
          return [true, "User #{login} has not write access to #{repo_name}."] if user.remove_access(repo, :write)
        end
        return [false, "An error occurred. Permissions was not modified."]
      end
    end
  end
end