module Gritano
  class Console
    
    attr_accessor :repo_path
    attr_accessor :ssh_path
    
    def initialize
      @repo_path = nil
      @ssh_path = nil
    end
    
    def execute(argv)
      send(argv[0..1].join('_').gsub('+', 'add_').gsub('-', 'remove_'), argv[2..-1])
    end
    
    def user_list(argv)
      msg = "Users:\n"
      users = User.all
      users.each do |user|
        msg += "  - #{user.login}\n"
      end
      msg = "there is no user registered" if users.count == 0
      return [true, msg]
    end
    
    def user_keys(argv)
      login, = argv
      user = User.find_by_login(login)
      if user
        keys = user.keys
        msg = "User's keys:\n"
        keys.each do |key|
          "  - #{key.name}\n"
        end
        msg = "there is no key registered" if keys.count == 0
        return [true, msg]
      else
        return [false, "User #{login} is not registered"]
      end
    end
    
    def user_repos(argv)
      login, = argv
      user = User.find_by_login(login)
      if user
        repos = user.repositories
        msg = "User's repositories:\n"
        repos.each do |repo|
          "  - #{repo.name}\n"
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
    
    def repo_list(argv)
      msg = "Repositories:\n"
      repos = Repository.all
      repos.each do |repo|
        msg += "  - #{repo.name}\n"
      end
      msg = "there is no repository registered" if repos.count == 0
      return [true, msg]
    end
    
    def repo_add(argv)
      name, = argv
      repo = Repository.new(name: name, path: @repo_path)
      return [true, "Repository #{name} created successfully."] if repo.save
      return [false, "Repository #{name} could not be created."]
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
    
    def repo_add_read(argv)
      repo_name, login = argv
      user = User.find_by_login(login)
      repo = Repository.find_by_name(repo_name)
      if repo and user
        return [true, "User #{login} has read access to #{repo_name}."] if user.add_access(repo, :read)
      end
      return [false, "An error occurred. Permissions was not modified."]
    end
    
    def repo_add_write(argv)
      repo_name, login = argv
      user = User.find_by_login(login)
      repo = Repository.find_by_name(repo_name)
      if repo and user
        return [true, "User #{login} has write access to #{repo_name}."] if user.add_access(repo, :write)
      end
      return [false, "An error occurred. Permissions was not modified."]
    end
    
    def repo_remove_read(argv)
      repo_name, login = argv
      user = User.find_by_login(login)
      repo = Repository.find_by_name(repo_name)
      if repo and user
        return [true, "User #{login} has not read access to #{repo_name}."] if user.remove_access(repo, :read)
      end
      return [false, "An error occurred. Permissions was not modified."]
    end
    
    def repo_remove_write(argv)
      repo_name, login = argv
      user = User.find_by_login(login)
      repo = Repository.find_by_name(repo_name)
      if repo and user
        return [true, "User #{login} has not write access to #{repo_name}."] if user.remove_access(repo, :write)
      end
      return [false, "An error occurred. Permissions was not modified."]
    end
    
    def user_add_key(argv)
      login, key_name, key_file = argv
      user = User.find_by_login(login)
      if File.exist?(key_file)
        if user
          key = user.keys.create(name: key_name, key: File.open(key_file).readlines.join)
          if key.valid?
            File.open(File.join(@ssh_path, 'authorized_keys'), 'w').write(Key.authorized_keys)
            return [true, "Key added successfully."]
          end
        end
      end
      return [false, "Key could not be added."]
    end
    
    def user_remove_key(argv)
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
  end
end