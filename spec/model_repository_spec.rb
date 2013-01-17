require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  describe Repository do
    def stub_hooks
      Repository.any_instance.stub(:create_bare_repo).and_return(:create_bare_repo)
      Repository.any_instance.stub(:destroy_bare_repo).and_return(:destroy_bare_repo)
    end
    
    it "should have a name" do
      stub_hooks
      repo = Repository.new(path: 'path')
      repo.should be_invalid
    end
    
    it "should have a unique name" do
      stub_hooks
      repo = Repository.create(name:'myrepo', path: 'path')
      repo.should be_valid
      repo = Repository.create(name:'myrepo', path: 'path')
      repo.should be_invalid
    end
    
    it "can have many users" do
      stub_hooks
      repo = Repository.create(name:'myrepo', path: 'path')
      repo.users.create(login: 'login1')
      repo.users.create(login: 'login2')
      repo.users.count.should == 2
    end
    
    it "have a full path" do
      stub_hooks
      repo = Repository.create(name:'myrepo', path: 'path')
      repo.full_path.should == 'path/myrepo'
    end
    
    it "have a full path even if it doesn't have a path" do
      stub_hooks
      repo = Repository.create(name:'myrepo')
      repo.full_path.should == 'myrepo'
    end
    
    it "should create a bare repo when it is created" do
      Grit::Repo.should_receive("init_bare").with('path/myrepo')
      Repository.create(name:'myrepo', path: 'path')
    end
    
    it "should remove the repository when it is destroyed" do
      Grit::Repo.should_receive("init_bare").with('path/myrepo')
      FileUtils.should_receive("rm_r").with('path/myrepo', force: true)
      repo = Repository.create(name:'myrepo', path: 'path')
      repo.destroy
    end
  end
end
