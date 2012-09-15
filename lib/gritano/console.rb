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
    
    def user_add(argv)
      login, = argv
      user = User.new(login: login)
      return true if user.save
      return false
    end
    
    def user_rm(argv)
      login, = argv
      user = User.find_by_login(login)
      if user
        if user.destroy
          return true 
        end
      end
      return false
    end
    
    def repo_add(argv)
      name, = argv
      repo = Repository.new(name: name, path: @repo_path)
      return true if repo.save
      return false
    end
    
    def repo_rm(argv)
      name, = argv
      repo = Repository.find_by_name(name)
      if repo
        if repo.destroy
          return true
        end
      end
      return false
    end
    
    def repo_add_read(argv)
      repo_name, login = argv
      user = User.find_by_login(login)
      repo = Repository.find_by_name(repo_name)
      if repo and user
        return user.add_access(repo, :read)
      end
      return false
    end
    
    def repo_add_write(argv)
      repo_name, login = argv
      user = User.find_by_login(login)
      repo = Repository.find_by_name(repo_name)
      if repo and user
        return user.add_access(repo, :write)
      end
      return false
    end
    
    def repo_remove_read(argv)
      repo_name, login = argv
      user = User.find_by_login(login)
      repo = Repository.find_by_name(repo_name)
      if repo and user
        return user.remove_access(repo, :read)
      end
      return false
    end
    
    def repo_remove_write(argv)
      repo_name, login = argv
      user = User.find_by_login(login)
      repo = Repository.find_by_name(repo_name)
      if repo and user
        return user.remove_access(repo, :write)
      end
      return false
    end
    
    def user_add_key(argv)
      login, key_name, key_file = argv
      user = User.find_by_login(login)
      if File.exist?(key_file)
        if user
          key = user.keys.create(name: key_name, key: File.open(key_file).readlines.join)
          if key.valid?
            File.open(File.join(@ssh_path, 'authorized_keys'), 'w').write(Key.authorized_keys)
            return true
          end
        end
      end
      return false
    end
    
    def user_remove_key(argv)
      login, key_name = argv
      key = Key.where(name: key_name).includes(:user).where("users.login" => login).limit(1)[0]
      if key
        if key.destroy
          File.open(File.join(@ssh_path, 'authorized_keys'), 'w').write(Key.authorized_keys)
          return true
        end
      end
      return false
    end
  end
end