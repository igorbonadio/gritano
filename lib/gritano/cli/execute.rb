module Gritano
  module CLI
    
    def CLI.execute_admin(cmd, stdin, user)
      if user and user.admin?
        CLI.execute(cmd, stdin)
      else
        puts "access denied"
      end
    end
    
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
        puts console.execute(["help"])
      end
    end
    
  end
end