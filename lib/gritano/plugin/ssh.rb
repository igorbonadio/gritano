require "sshd_config"

module Gritano
  class Ssh < Plugin
    
    def self.info
      "It installs a patched OpenSSH version used by Gritano that enables SSH lookup for public keys in a database"
    end
    
    def on_add
      File.open(File.join(@home_dir, '.gritano', 'config.yml'), "w").write({'ssh' => true}.to_yaml)
      File.open(File.join(@ssh_path, 'authorized_keys'), "w").write('')
      gritano_pub_key_path = `which gritano-pub-key`[0..-2]
      `ln -s #{gritano_pub_key_path} #{File.join(@home_dir, '.gritano', 'gritano-pub-key')}`
    end
    
    def on_remove
      File.open(File.join(@home_dir, '.gritano', 'config.yml'), "w").write({'ssh' => false}.to_yaml)
      File.open(File.join(@ssh_path, 'authorized_keys'), 'w').write(Key.authorized_keys)
      FileUtils.rm(File.join(@home_dir, '.gritano', 'gritano-pub-key')) if File.exist?(File.join(@home_dir, '.gritano', 'gritano-pub-key'))
    end
    
    def self.check_install
      home = Etc.getpwuid.dir
      if File.exist?(File.join(home, '.gritano', 'config.yml'))
        config = YAML::load(File.open(File.join(home, '.gritano', 'config.yml')))
        return config['ssh']
      else
        return false
      end
    end
    
    add_command "help" do |params|
      Ssh.help
    end
    
    add_command "install", "gritano_path" do |params|
      gritano_dir, = params
      FileUtils.rm_rf(File.join('/tmp', 'gritano-openssh')) if Dir.exist?(File.join('/tmp', 'gritano-openssh'))
      
      puts "[git] Cloning"
      ok = system "git clone git://github.com/igorbonadio/gritano-openssh.git /tmp/gritano-openssh"
      if ok
        puts "[build] Configuring"
        ok = system "cd /tmp/gritano-openssh/src && ./configure"
        if ok
          puts "[build] Compiling"
          ok = system "cd /tmp/gritano-openssh/src && make"
          if ok
            puts "[build] Installing"
            ok = system "cd /tmp/gritano-openssh/src && make install"
            if ok
              gritano_pub_key = File.join(gritano_dir, 'gritano-pub-key')
              File.open(File.join("/usr", "local", "etc", "sshd_config"), "a") do |f|
                f.write("\n\nAuthorizedKeysScript #{gritano_pub_key}\n\n")
              end
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