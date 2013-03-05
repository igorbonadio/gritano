module Gritano
  class Plugin
    
    def initialize(stdin = STDIN, home_dir = Etc.getpwuid.dir, repo_path = Etc.getpwuid.dir)
      @stdin = stdin
      @home_dir = home_dir
      @repo_path = repo_path
      @ssh_path = File.join(@home_dir, '.ssh')
    end
    
    def add
      on_add
    end
    
    def remove
      on_remove
    end
    
    def on_add
      raise NotImplementedError
    end
    
    def on_remove
      raise NotImplementedError
    end
    
    def exec(cmd)
      method = cmd[0].split(':').join('_')
      params = cmd[1..-1]
      send(method, params)
    end
    
    def self.name
      self.to_s.downcase.split('::')[-1]
    end
    
    def self.info
      raise NotImplementedError
    end
    
    def self.check_install
      false
    end
    
    def self.list
      @subclass
    end
    
    def self.inherited(subclass)
      if @subclass
        @subclass << subclass
      else
        @subclass = {subclass.name => {klass: subclass, installed: lambda { subclass.check_install }}}
      end
    end
    
    def self.add_command(command, parameters = "", &block)
      define_method(command.gsub(':', '_'), &block)
      commands[command] = parameters
    end
    
    def self.commands
      @commands || @commands = Hash.new
    end
    
    def self.bin_name=(name)
      @bin_name = name
    end
    
    def self.bin_name
      @bin_name || "gritano "
    end
    
    def self.help
      msg = "  #{self.bin_name}plugin:exec #{self.name} [command]\n\n"
      msg += "  Examples:\n"
      commands.each do |command, parameters|
        msg += "  #{self.bin_name}plugin:exec #{self.name} #{command} #{parameters}\n"
      end
      msg += "\n  --\n  v#{File.open(File.join(File.dirname(__FILE__), '..', '..', 'VERSION')).readlines.join}"
      msg
    end
    
  end
end

require File.join(ROOT_PATH, 'gritano/plugin/ssh')