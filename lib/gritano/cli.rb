module Gritano
  module CLI
    
    def CLI._execute(cmd, console)
      begin
        output = console.execute(cmd)
        if output[0]
          output[1].to_s
        else
          "error: #{output[1]}"
        end
      rescue
        console.execute(["help"])[1]
      end
    end
    
    def CLI.execute(cmd, stdin = STDIN, home_dir = Etc.getpwuid.dir, repo_dir = Etc.getpwuid.dir)
      Gritano::Console.remote_console(false)
      _execute(cmd, Gritano::Console::Gritano.new(stdin, home_dir, repo_dir))
    end
    
    def CLI.check(cmd, login, stdin = STDIN, home_dir = Etc.getpwuid.dir, repo_dir = Etc.getpwuid.dir)
      Gritano::Console.remote_console(true)
      _execute(cmd + [login], Gritano::Console::Remote.new(stdin, home_dir, repo_dir))
    end
  end
end
