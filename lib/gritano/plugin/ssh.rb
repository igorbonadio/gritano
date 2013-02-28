module Gritano
  class Ssh < Plugin
    def self.info
      "Install a patched OpenSSH version used by Gritano that enables SSH lookup for public keys in a database"
    end
    
    add_command "install" do |params|
    end
    
    add_command "uninstall" do |params|
    end
    
    add_command "start" do |params|
    end
    
    add_command "stop" do |params|
    end
    
  end
end