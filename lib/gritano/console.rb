module Gritano
  class Console
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
      repo = Repository.new(name: name)
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
      login, repo_name = argv
      user = User.find_by_login(login)
      repo = Repository.find_by_name(repo_name)
      if repo and user
        return user.add_access(repo, :read)
      end
      return false
    end
    
    def repo_add_write(argv)
      login, repo_name = argv
      user = User.find_by_login(login)
      repo = Repository.find_by_name(repo_name)
      if repo and user
        return user.add_access(repo, :write)
      end
      return false
    end
    
    def repo_remove_read(argv)
      login, repo_name = argv
      user = User.find_by_login(login)
      repo = Repository.find_by_name(repo_name)
      if repo and user
        return user.remove_access(repo, :read)
      end
      return false
    end
    
    def repo_remove_write(argv)
      login, repo_name = argv
      user = User.find_by_login(login)
      repo = Repository.find_by_name(repo_name)
      if repo and user
        return user.remove_access(repo, :write)
      end
      return false
    end
    
    def repo_rename(argv)
      old_name, new_name = argv
      repo = Repository.find_by_name(old_name)
      if repo
        repo.name = new_name
        return repo.save
      end
      return false
    end
  end
end