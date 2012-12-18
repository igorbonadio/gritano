module Gritano
  module CLI
    def CLI.execute(cmd, stdin)
      console = Gritano::Console::Gritano.new(stdin)
      begin
        output = console.execute(ARGV)
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