require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  describe Ssh do
    it "should show information" do
      Ssh.new.info.should be == "Install a patched OpenSSH version used by Gritano that enables SSH lookup for public keys in a database"
    end
    
  end
end