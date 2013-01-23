require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  module Console
    describe Gritano do
      def create_gritano(home, repo_dir)
        stdin = double()
        stdin.stub(:read).and_return("Your SSHKEY here...")
        Gritano.new(stdin, home, repo_dir)
      end
      
      def test_console_call(console, msg)
        executor = double()
        executor.should_receive(:execute).with(msg)
        console.should_receive(:new).and_return(executor)
        create_gritano('.', 'tmp').execute(msg)
      end
      
      def test_executor(msg)
        test_console_call(Executor, msg)
      end
      
      def test_installer(msg)
        test_console_call(Installer, msg)
      end
      
      it "should show the complete help" do
        create_gritano(".", "tmp").
          execute(["help"])[1].
            should == File.open("features/data/local_help.txt").readlines.join.
              gsub('{{VERSION}}', File.open("VERSION").readlines.join)
      end
      
      it "should show the version" do
        create_gritano(".", "tmp").
          execute(["version"])[1].
            should == "v#{File.open("VERSION").readlines.join}"
      end
      
      it "should list users" do
        test_executor(["user:list"])
      end
      
      it "should list users' keys" do
        test_executor(["user:key:list", "login"])
      end
      
      it "should list users' repos" do
        test_executor(["user:repo:list", "login"])
      end
      
      it "should add users" do
        test_executor(["user:add", "login"])
      end
      
      it "should remove users" do
        test_executor(["user:rm", "login"])
      end
      
      it "should add users' keys" do
        test_executor(["user:key:add", "login", "keyname"])
      end
      
      it "should remove users' keys" do
        test_executor(["user:key:rm", "login", "keyname"])
      end
      
      it "should add admin rights to user" do
        test_executor(["user:admin:add", "login"])
      end
      
      it "should remove admin rights from users" do
        test_executor(["user:admin:rm", "login"])
      end
      
      it "should list repos" do
        test_executor(["repo:list"])
      end
      
      it "should create repos" do
        test_executor(["repo:add", "repo.git"])
      end
      
      it "should create repos and add a user" do
        test_executor(["repo:add", "repo.git", "login"])
      end
      
      it "should list repos' users" do
        test_executor(["repo:user:list", "repo.git"])
      end
      
      it "should remove repos" do
        test_executor(["repo:rm", "repo.git"]) 
      end
      
      it "should allow user to read a repo" do
        test_executor(["repo:read:add", "repo.git", "login"]) 
      end
      
      it "should allow user to write to a repo" do
        test_executor(["repo:write:add", "repo.git", "login"])
      end
      
      it "should deny user to read a repo" do
        test_executor(["repo:read:rm", "repo.git", "login"])
      end
      
      it "should deny user to write to a repo"do
        test_executor(["repo:write:rm", "repo.git", "login"])
      end
      
      it "should prepare the environment" do
        test_installer(["setup:prepare"])
      end
      
      it "should install" do
        test_installer(["setup:install"])
      end
    end
  end
end