module Gritano
  module CLI
    def CLI.execute(cmd, stdin = STDIN, home_dir = Etc.getpwuid.dir, repo_dir = Etc.getpwuid.dir)
      console = Gritano::Console::Gritano.new(stdin, home_dir, repo_dir)
      begin
        output = console.execute(cmd)
        if output[0]
          output[1]
        else
          "error: #{output[1]}"
        end
      rescue
        console.execute(["help"])[1]
      end
    end
    
    def CLI.check(cmd, login, stdin = STDIN, home_dir = Etc.getpwuid.dir, repo_dir = Etc.getpwuid.dir)
      Gritano::Console.bin_name('ssh git@host.com')
      console = Gritano::Console::Check.new(stdin, home_dir, repo_dir)
      begin
        output = console.execute(cmd + [login])
        if output[0]
          output[1]
        else
          "error: #{output[1]}"
        end
      rescue
        console.execute(["help"])[1]
      end
    end
  end
end
