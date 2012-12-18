module Gritano
  module CLI
    
    def CLI.git(cmd, user, repo)
      if user and repo
        if user.check_access(repo, command[:access])
          exec "#{command[:command]} #{File.join(repo.full_path)}"
        end
      end
    end
    
  end
end