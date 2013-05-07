require "sshd_config"

module Gritano
  class Ssh < Plugin
    
    def self.info
      "It installs a patched OpenSSH version used by Gritano that enables SSH lookup for public keys in a database"
    end
    
    def on_add
      config = Config.new(File.join(@home_dir, '.gritano', 'config.yml'))
      config.ssh = true
      config.save
      File.open(File.join(@ssh_path, 'authorized_keys'), "w").write('')
      gritano_pub_key_path = `which gritano-pub-key`[0..-2]
      `ln -s #{gritano_pub_key_path} #{File.join(@home_dir, '.gritano', 'gritano-pub-key')}`
    end
    
    def on_remove
      config = Config.new(File.join(@home_dir, '.gritano', 'config.yml'))
      config.ssh = false
      config.save
      File.open(File.join(@ssh_path, 'authorized_keys'), 'w').write(Key.authorized_keys)
      FileUtils.rm(File.join(@home_dir, '.gritano', 'gritano-pub-key')) if File.exist?(File.join(@home_dir, '.gritano', 'gritano-pub-key'))
    end
    
    def self.check_install
      home = Etc.getpwuid.dir
      if File.exist?(File.join(home, '.gritano', 'config.yml'))
        config = Config.new(File.join(home, '.gritano', 'config.yml'))
        if config.ssh
          return config.ssh
        else
          return false
        end
      else
          return false
      end
    end

    def self.servername
      home = Etc.getpwuid.dir
      if File.exist?(File.join(home, '.gritano', 'config.yml'))
        config = Config.new(File.join(home, '.gritano', 'config.yml'))
        if config.ssh_servername
          return config.ssh_servername
        end
      end
      return "git@host.com"
    end
    
    add_command "help" do |params|
      Ssh.help
    end
    
    add_command "install", "gritano_path" do |params|
      gritano_dir, = params
      FileUtils.rm_rf(File.join('/tmp', 'gritano-openssh')) if Dir.exist?(File.join('/tmp', 'gritano-openssh'))
      
      puts "[git] Cloning"
      if system "git clone git://github.com/igorbonadio/gritano-openssh.git /tmp/gritano-openssh"
        puts "[build] Configuring"
        if system "cd /tmp/gritano-openssh/src && ./configure"
          puts "[build] Compiling"
          if system "cd /tmp/gritano-openssh/src && make"
            puts "[build] Installing"
            if system "cd /tmp/gritano-openssh/src && make install"
              sshd_config = SshdConfig::SshdConfig.read(File.join("/usr", "local", "etc", "sshd_config"))
              sshd_config.AuthorizedKeysScript = File.join(gritano_dir, 'gritano-pub-key')
              sshd_config.save
              return "Installed"
            end
          end
        end
      end
      
      return "error"
    end
    
    add_command "start" do |params|
      `/usr/local/sbin/sshd`
    end
    
    add_command "stop" do |params|
      pid = `ps aux | grep -e /usr/local/sbin/sshd | grep -v grep | tr -s \" \" | cut -d \" \" -f2`
      `kill -9 #{pid}`
    end

    add_command "servername:get" do |params|
      return Ssh.servername
    end

    add_command "servername:set", "servername" do |params|
      servername, = params
      home = Etc.getpwuid.dir
      config = Config.new(File.join(home, '.gritano', 'config.yml'))
      config.ssh_servername = servername
      config.save
      return "done!"
    end
    
    def method_missing(name, *args, &body)
      case name.to_s
        when /^get_/ then
          begin
            sshd_config = SshdConfig::SshdConfig.read(File.join("/usr", "local", "etc", "sshd_config"))
            return sshd_config.send(name.to_s.gsub(/^get_/, ''))
          rescue Exception => e
            return "invalid property"
          end
        when /^set_/ then
          sshd_config = SshdConfig::SshdConfig.read(File.join("/usr", "local", "etc", "sshd_config"))
          sshd_config.send("#{name.to_s.gsub(/^set_/, '')}=", args[0])
          sshd_config.save
          return "property #{name.to_s.gsub(/^set_/, '')} updated"
      end
      raise NoMethodError
    end
    
  end
end