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
    
    add_command "help" do |params|
      Ssh.help
    end
    
    add_command "install" do |params|
      FileUtils.rm_rf(File.join('/tmp', 'gritano-openssh')) if Dir.exist?(File.join('/tmp', 'gritano-openssh'))
      puts "[git] Cloning"
      `git clone git://github.com/igorbonadio/gritano-openssh.git /tmp/gritano-openssh`
      puts "[build] Configuring"
      `cd /tmp/gritano-openssh/src && ./configure`
      puts "[build] Compiling"
      `cd /tmp/gritano-openssh/src && make`
      puts "[build] Installing"
      `cd /tmp/gritano-openssh/src && make install`
    end
    
    add_command "start" do |params|
    end
    
    add_command "stop" do |params|
    end
    
  end
end