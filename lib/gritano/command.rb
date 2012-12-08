module Gritano
  class Command
    def self.eval(cmd)
      case cmd
        when /^git-receive-pack/ then
          return {access: :write, command: "git-receive-pack", repo: self.repo(cmd)}
        when /^git-upload-pack/ then
          return {access: :read, command: "git-upload-pack", repo: self.repo(cmd)}
        when /^repo:/ then
          return {access: :user_cmd, command: ("user:#{cmd} [USER]")}
        when /^key:/ then
          cmd = cmd.split(" ")
          cmd = [cmd[0]] + ["[USER]"] + cmd[1..-1]
          return {access: :user_cmd, command: ("user:" + cmd.join(" "))}
        when /admin:/ then
          return {access: :admin_cmd, command: cmd.gsub("admin:", "")}
      end
    end
    
    def self.repo(cmd)
      cmd.gsub(/^git-receive-pack/, '').gsub(/^git-upload-pack/, '').gsub("'", '').strip
    end
  end
end