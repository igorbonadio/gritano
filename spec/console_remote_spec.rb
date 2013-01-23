require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  module Console
    describe Remote do
      def create_remote(home, repo_dir)
        stdin = double()
        stdin.stub(:read).and_return("Your SSHKEY here...")
        Remote.new(stdin, home, repo_dir)
      end
      
      def test_remote_execute(cmd)
        _cmd = ["user:" + cmd[0]] + ["login"] + cmd[1..-1]
        Executor.any_instance.should_receive(:execute).with(_cmd)
        create_remote(".", "tmp").execute(cmd + ["login"])
      end
      
      it "should show a help message" do
        create_remote(".", "tmp").
          execute(["help"])[1].
            should == File.open("features/data/remote_help.txt").readlines.join.
              gsub('{{VERSION}}', File.open("VERSION").readlines.join)
      end
      
      it "should show the version" do
        create_remote(".", "tmp").
          execute(["version"])[1].
            should == "v#{File.open("VERSION").readlines.join}"
      end
      
      it "should list user's repositories" do
        test_remote_execute(["repo:list"])
      end
      
      it "should list user's keys" do
        test_remote_execute(["key:list"])
      end
      
      it "should add a key" do
        test_remote_execute(["key:add", "keyname"])
      end
      
      it "should remove a key" do
        test_remote_execute(["key:rm", "keyname"])
      end
      
      it "should execute admin commands" do
        admin = double()
        admin.should_receive(:admin?).and_return(true)
        ::Gritano::User.should_receive(:find_by_login).and_return(admin)
        remote = create_remote(".", "tmp")
        remote.should_receive(:admin_command)
        remote.execute(["admin:user:list"])
      end
      
      it "should get a git repository" do
        remote = create_remote(".", "tmp")
        remote.should_receive(:git_receive_pack)
        remote.execute(["git-receive-pack"])
      end
      
      it "should send a git repository" do
        remote = create_remote(".", "tmp")
        remote.should_receive(:git_upload_pack)
        remote.execute(["git-upload-pack"])
      end
      
    end
  end
end