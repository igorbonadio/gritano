module Gritano
  class Command
    def self.eval(cmd)
      case cmd
        when /^git-receive-pack/ then
          return {access: :write, command: "git-receive-pack", repo: self.repo(cmd)}
        when /^git-upload-pack/ then
          return {access: :read, command: "git-upload-pack", repo: self.repo(cmd)}
        when /^repos/, /^keys/, /^\+key/, /^\-key/ then 
          return {access: :user_cmd, command: cmd}
      end
    end
    
    def self.repo(cmd)
      cmd.gsub(/^git-receive-pack/, '').gsub(/^git-upload-pack/, '').gsub("'", '').strip
    end
  end
end