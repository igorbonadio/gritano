module Gritano
  module CLI
    
    def CLI.git(cmd, user, repo)
      if user and repository
        if user.check_access(repository, command[:access])
          exec "#{command[:command]} #{File.join(repository.full_path)}"
        end
      end
    end
    
  end
end