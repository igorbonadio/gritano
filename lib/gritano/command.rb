module Gritano
  class Command
    def self.eval(cmd)
      case cmd
        when /^git-receive-pack/ then
          return :write, self.repo(cmd)
        when /^git-upload-pack/ then
          return :read, self.repo(cmd)
      end
    end
    
    def self.repo(cmd)
      cmd.gsub(/^git-receive-pack/, '').gsub(/^git-upload-pack/, '').gsub("'", '').strip
    end
  end
end