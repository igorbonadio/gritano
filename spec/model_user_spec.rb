require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  describe User do
    before(:each) do
      Repository.any_instance.stub(:create_bare_repo).and_return(:create_bare_repo)
      Repository.any_instance.stub(:destroy_bare_repo).and_return(:destroy_bare_repo)
    end
    
    it "should have a login" do
      user = User.new()
      user.should be_invalid
    end
    
    it "should have an unique login" do
      User.create(login: 'user')
      user = User.new(login: 'user')
      user.should be_invalid
    end
    
    it "can have many repositories" do
      user = User.create(login: 'user')
      user.repositories.count.should == 0
      user.repositories.create(name:'myrepo', path: 'path')
      user.repositories.count.should == 1
      user.repositories.create(name:'myrepo2', path: 'path2')
      user.repositories.count.should == 2
      user.repositories.create(name:'myrepo3', path: 'path3')
      user.repositories.count.should == 3
    end
    
    it "can have many keys" do
      user = User.create(login: 'user')
      user.keys.count.should == 0
      user.keys.create(name: "mykey", key: "sshkey")
      user.keys.count.should == 1
      user.keys.create(name: "mykey2", key: "sshkey2")
      user.keys.count.should == 2
      user.keys.create(name: "mykey3", key: "sshkey3")
      user.keys.count.should == 3
    end
    
    it "can be admin" do
      user = User.create(login: 'user', admin: true)
      user.should be_admin
      user = User.create(login: 'user')
      user.should_not be_admin
    end
    
    it "should add READ access to a reporitory" do
      user = User.create(login: 'user')
      repo = Repository.create(name:'myrepo', path: 'path')
      user.add_access(repo, :read).should be_true
    end
    
    it "should add WRTIE access to a reporitory" do
      user = User.create(login: 'user')
      repo = Repository.create(name:'myrepo', path: 'path')
      user.add_access(repo, :write).should be_true
    end
    
    it "should not add an UNKNOWN access to a repository" do
      user = User.create(login: 'user')
      repo = Repository.create(name:'myrepo', path: 'path')
      user.add_access(repo, :wrong).should be_false
    end
    
    it "should remove READ access to a reporitory" do
      user = User.create(login: 'user')
      repo = Repository.create(name:'myrepo', path: 'path')
      user.remove_access(repo, :read).should be_true
    end
    
    it "should remove WRTIE access to a reporitory" do
      user = User.create(login: 'user')
      repo = Repository.create(name:'myrepo', path: 'path')
      user.remove_access(repo, :write).should be_true
    end
    
    it "should check READ access" do
      user = User.create(login: 'user')
      repo = Repository.create(name:'myrepo', path: 'path')
      user.check_access(repo, :read).should be_false
      user.add_access(repo, :read).should be_true
      user.check_access(repo, :read).should be_true
    end
    
    it "should check WRITE access" do
      user = User.create(login: 'user')
      repo = Repository.create(name:'myrepo', path: 'path')
      user.check_access(repo, :write).should be_false
      user.add_access(repo, :write).should be_true
      user.check_access(repo, :write).should be_true
    end
  end
end