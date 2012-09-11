module Gritano
  class Command
    def self.eval(cmd)
      case cmd
        when /^git-receive-pack/ then
          return :write, "git-receive-pack", self.repo(cmd)
        when /^git-upload-pack/ then
          return :read, "git-upload-pack", self.repo(cmd)
      end
    end
    
    def self.repo(cmd)
      cmd.gsub(/^git-receive-pack/, '').gsub(/^git-upload-pack/, '').gsub("'", '').strip
    end
  end
end