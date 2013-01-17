require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  describe Key do
    
    it "should have a name" do
      key = Gritano::Key.new(key: "key")
      key.should be_invalid
    end
    
    it "should have a ssh key" do
      key = Gritano::Key.new(name: "name")
      key.should be_invalid
    end
    
    it "should have a unique name per user" do
      user = User.create(login: "igor")
      user.keys.create(name: "mykey", key: "sshkey")
      user.keys.create(name: "mykey", key: "sshkey").should be_invalid
      user.keys.count.should == 1
    end
    
    it "should belongs to a user" do
      user = User.create(login: "igor")
      key = user.keys.create(name: "mykey", key: "sshkey")
      key.user.should == user
    end
    
    it "should generate the authorized_keys files" do
      user = User.create(login: "igor")
      key = user.keys.create(name: "mykey", key: "sshkey")
      Key.authorized_keys.should == "command=\"gritano-remote igor\" sshkey\n"
    end
  end
end