require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  module Console
    describe Executor do
      def create_executor(home, repo_dir)
        stdin = double()
        stdin.stub(:read).and_return("ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9UnnlDwmvid+WRAyIhVzFhIjUUxA3Wul7LN8mk18dHZDv5HSVADmM4EoqbVSbpeVIyTIchqS3y3XF1rh8dfM41f/W3lcTcFihHM6RDx45Q3Lz9hfyrT8tttlWRA7prvlXu6bUOqMmNtvFFow+bJEo/HgCZHshvoDHcnlHfziU7bDCo+p50SdafFwZRe3AWp/f4TsxiP7jpBnluQM0Dl9Om8jfW8IYAJ+WxlKBsKLMkRH/HWSuigs4AQBD4ADiQfOm2RO4yeSiVFNwGFmgG7NmEq1sNALLAQw+ijN9vyiD99ybr0pqoJX3vhyRBWvCrgQdHjh8ucaoMXI89LxyYts/ igorbonadio@marvin.local")
        Executor.new(stdin, home, repo_dir)
      end
      
      it "should list users" do
        User.should_receive(:all).and_return([])
        create_executor('.', 'tmp').execute(["user:list"])
      end
      
      it "should list users' keys" do
        user = double()
        user.should_receive(:keys).and_return([])
        User.should_receive(:find_by_login).with("login").and_return(user)
        create_executor('.', 'tmp').execute(["user:key:list", "login"])
      end
      
      it "should list users' repos" do
        user = double()
        user.should_receive(:repositories).and_return([])
        User.should_receive(:find_by_login).with("login").and_return(user)
        create_executor('.', 'tmp').execute(["user:repo:list", "login"])
      end
      
      it "should add users" do
        user = double()
        user.should_receive(:save).and_return(true)
        User.should_receive(:new).with(login: "login", email: nil, admin: false).and_return(user)
        create_executor('.', 'tmp').execute(["user:add", "login"])
      end
      
      it "should remove users" do
        user = double()
        user.should_receive(:destroy).and_return(true)
        User.should_receive(:find_by_login).with("login").and_return(user)
        create_executor('.', 'tmp').execute(["user:rm", "login"])
      end
      
      it "should add users' keys" do
        user = double()
        keys = double()
        key = double()
        key.should_receive(:valid?).and_return(true)
        keys.should_receive(:create).with(name: "keyname", key: "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9UnnlDwmvid+WRAyIhVzFhIjUUxA3Wul7LN8mk18dHZDv5HSVADmM4EoqbVSbpeVIyTIchqS3y3XF1rh8dfM41f/W3lcTcFihHM6RDx45Q3Lz9hfyrT8tttlWRA7prvlXu6bUOqMmNtvFFow+bJEo/HgCZHshvoDHcnlHfziU7bDCo+p50SdafFwZRe3AWp/f4TsxiP7jpBnluQM0Dl9Om8jfW8IYAJ+WxlKBsKLMkRH/HWSuigs4AQBD4ADiQfOm2RO4yeSiVFNwGFmgG7NmEq1sNALLAQw+ijN9vyiD99ybr0pqoJX3vhyRBWvCrgQdHjh8ucaoMXI89LxyYts/").and_return(key)
        user.should_receive(:keys).and_return(keys)
        User.should_receive(:find_by_login).with("login").and_return(user)
        create_executor('.', 'tmp').execute(["user:key:add", "login", "keyname"])
      end
      
      it "should remove users' keys" do
        keys = double()
        users = double()
        limit = double()
        key = double()
        key.should_receive(:destroy).and_return(true)
        limit.should_receive(:limit).with(1).and_return([key])
        users.should_receive(:where).with("users.login" => "login").and_return(limit)
        keys.should_receive(:includes).with(:user).and_return(users)
        Key.should_receive(:where).with(name: "keyname").and_return(keys)
        create_executor('.', 'tmp').execute(["user:key:rm", "login", "keyname"])
      end
      
      it "should add admin rights to user" do
        user = double()
        user.should_receive(:admin=).with(true)
        user.should_receive(:save).and_return(true)
        User.should_receive(:find_by_login).with("login").and_return(user)
        create_executor('.', 'tmp').execute(["user:admin:add", "login"])
      end
      
      it "should remove admin rights from users" do
        user = double()
        user.should_receive(:admin=).with(false)
        user.should_receive(:save).and_return(true)
        User.should_receive(:find_by_login).with("login").and_return(user)
        create_executor('.', 'tmp').execute(["user:admin:rm", "login"])
      end
      
      it "should list repos" do
        Repository.should_receive(:all).and_return([])
        create_executor('.', 'tmp').execute(["repo:list"])
      end
      
      it "should create repos" do
        repo = double()
        repo.should_receive(:save).and_return(true)
        Repository.should_receive(:new).with(name: "repo.git", path: "tmp").and_return(repo)
        create_executor('.', 'tmp').execute(["repo:add", "repo.git"])
      end
      
      it "should create repos and add a user" do
        repo = double()
        repo.should_receive(:save).and_return(true)
        Repository.should_receive(:new).with(name: "repo.git", path: "tmp").and_return(repo)
        
        user = double()
        user.should_receive(:add_access).twice
        User.should_receive(:find_by_login).with("login").and_return(user)
        
        create_executor('.', 'tmp').execute(["repo:add", "repo.git", "login"])
      end
      
      it "should list repos' users" do
        repo = double()
        repo.should_receive(:users).and_return([])
        Repository.should_receive(:find_by_name).with("repo.git").and_return(repo)
        create_executor('.', 'tmp').execute(["repo:user:list", "repo.git"])
      end
      
      it "should remove repos" do
        repo = double()
        repo.should_receive(:destroy).and_return(true)
        Repository.should_receive(:find_by_name).with("repo.git").and_return(repo)
        create_executor('.', 'tmp').execute(["repo:rm", "repo.git"]) 
      end
      
      it "should allow user to read a repo" do
        repo = double()
        Repository.should_receive(:find_by_name).with("repo.git").and_return(repo)
        
        user = double()
        user.should_receive(:add_access).with(repo, :read).and_return(true)
        User.should_receive(:find_by_login).with("login").and_return(user)
        
        create_executor('.', 'tmp').execute(["repo:read:add", "repo.git", "login"]) 
      end
      
      it "should allow user to write to a repo" do
        repo = double()
        Repository.should_receive(:find_by_name).with("repo.git").and_return(repo)
        
        user = double()
        user.should_receive(:add_access).with(repo, :write).and_return(true)
        User.should_receive(:find_by_login).with("login").and_return(user)
        
        create_executor('.', 'tmp').execute(["repo:write:add", "repo.git", "login"])
      end
      
      it "should deny user to read a repo" do
        repo = double()
        Repository.should_receive(:find_by_name).with("repo.git").and_return(repo)
        
        user = double()
        user.should_receive(:remove_access).with(repo, :read).and_return(true)
        User.should_receive(:find_by_login).with("login").and_return(user)
        
        create_executor('.', 'tmp').execute(["repo:read:rm", "repo.git", "login"])
      end
      
      it "should deny user to write to a repo"do
        repo = double()
        Repository.should_receive(:find_by_name).with("repo.git").and_return(repo)
        
        user = double()
        user.should_receive(:remove_access).with(repo, :write).and_return(true)
        User.should_receive(:find_by_login).with("login").and_return(user)
        
        create_executor('.', 'tmp').execute(["repo:write:rm", "repo.git", "login"])
      end
    end
  end
end