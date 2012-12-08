require "terminal-table"

module Gritano
  class Console
    
    attr_accessor :repo_path
    attr_accessor :ssh_path
    
    def initialize(stdin)
      @repo_path = nil
      @ssh_path = nil
      @stdin = stdin
    end
    
    def execute(argv)
      send(argv[0].gsub(':', '_'), argv[1..-1])
    end
    
    def user_list(argv)
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
    
    def user_key_list(argv)
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
    
    def user_repo_list(argv)
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
    
    def user_add(argv)
      login, = argv
      user = User.new(login: login)
      return [true, "User #{login} added."] if user.save
      return [false, "#{user.errors.full_messages.join(", ")}."]
    end
    
    def user_rm(argv)
      login, = argv
      user = User.find_by_login(login)
      if user
        if user.destroy
          return [true, "User #{login} removed."] 
        end
      end
      return [false, "User #{login} could not be removed."]
    end
    
    def user_key_add(argv)
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
    
    def user_key_rm(argv)
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
    
    def user_admin_add(argv)
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
    
    def user_admin_rm(argv)
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
    
    def repo_list(argv)
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
    
    def repo_add(argv)
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
    
    def repo_user_list(argv)
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
    
    def repo_rm(argv)
      name, = argv
      repo = Repository.find_by_name(name)
      if repo
        if repo.destroy
          return [true, "Repository #{name} removed successfully."]
        end
      end
      return [false, "Repository #{name} could not be removed."]
    end
    
    def repo_read_add(argv)
      repo_name, login = argv
      user = User.find_by_login(login)
      repo = Repository.find_by_name(repo_name)
      if repo and user
        return [true, "User #{login} has read access to #{repo_name}."] if user.add_access(repo, :read)
      end
      return [false, "An error occurred. Permissions was not modified."]
    end
    
    def repo_write_add(argv)
      repo_name, login = argv
      user = User.find_by_login(login)
      repo = Repository.find_by_name(repo_name)
      if repo and user
        return [true, "User #{login} has write access to #{repo_name}."] if user.add_access(repo, :write)
      end
      return [false, "An error occurred. Permissions was not modified."]
    end
    
    def repo_read_rm(argv)
      repo_name, login = argv
      user = User.find_by_login(login)
      repo = Repository.find_by_name(repo_name)
      if repo and user
        return [true, "User #{login} has not read access to #{repo_name}."] if user.remove_access(repo, :read)
      end
      return [false, "An error occurred. Permissions was not modified."]
    end
    
    def repo_write_rm(argv)
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