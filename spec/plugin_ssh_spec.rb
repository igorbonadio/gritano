require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  describe Ssh do
    it "should show information" do
      Ssh.info.should be == "Install a patched OpenSSH version used by Gritano that enables SSH lookup for public keys in a database"
    end
    
    it "should show the help" do
      Ssh.help.should be == File.open("features/data/ssh_help.txt").readlines.join.
                                      gsub('{{VERSION}}', File.open("VERSION").readlines.join)
    end
    
  end
end