module Gritano
  class Http < Plugin
    
    def self.info
      "TODO"
    end
    
    def on_add
      config = Config.new(File.join(@home_dir, '.gritano', 'config.yml'))
      config.http = true
      config.save
    end
    
    def on_remove
      config = Config.new(File.join(@home_dir, '.gritano', 'config.yml'))
      config.http = false
      config.save
    end
    
    def self.check_install
      home = Etc.getpwuid.dir
      if File.exist?(File.join(home, '.gritano', 'config.yml'))
        config = Config.new(File.join(home, '.gritano', 'config.yml'))
        if config.http
          return config.http
        else
          return false
        end
      else
          return false
      end
    end

    add_command "help" do |params|
      Http.help
    end

    add_command "install", "install_dir" do |params|
      install_dir, = params
      puts "[git] Cloning"
      if system "git clone git://github.com/igorbonadio/gritano-grack.git #{install_dir}"
        puts "Please, edit the gritano-grack/config.yml file to finish your installation."
        return "Done"
      end
      return "error"
    end
    
  end
end