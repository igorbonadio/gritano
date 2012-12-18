module Gritano
  module CLI
    def CLI.execute(cmd, stdin)
      console = Gritano::Console::Gritano.new(stdin)
      begin
        output = console.execute(cmd)
        if output[0]
          puts output[1]
        else
          puts "error: #{output[1]}"
        end
      rescue
        puts console.execute(["help"])[1]
      end
    end
    
    def CLI.check(cmd, login, stdin)
      begin
        console = Gritano::Console::Check.new(stdin)
        output = console.execute(cmd.split(' ') + [login])
        if output[0]
          puts output[1]
        else
          puts "error: #{output[1]}"
        end
      rescue
        puts console.execute(["help"])[1]
      end
    end
  end
end