require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module Gritano::CLI::Console
  describe Git do
    before(:each) do
      $stdout.stub(:puts)
      $stdin.stub(:readlines).and_return(['some pubkey'])
      ActiveRecord::Base.stub(:establish_connection)
      File.stub(:open)
      YAML.stub(:load)
      Gritano::CLI::Config.remote_user = 'user_login'
    end

    it "should execute git-receive-pack if the user has write access" do
      user = double('User')
      repo = double('Repository')
      Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
      Gritano::Core::Repository.should_receive(:where).with(name: 'repo.git').and_return([repo])
      user.should_receive(:check_access).with(repo, :write).and_return(true)
      repo.should_receive(:full_path).and_return('folder/repo.git')
      Kernel.should_receive(:exec).with("git-receive-pack 'folder/repo.git'")
      Gritano::CLI::Console::Git.start %w{git:receive:pack repo.git}
    end

    it "should not execute git-receive-pack if the user has not write access" do
      user = double('User')
      repo = double('Repository')
      Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
      Gritano::Core::Repository.should_receive(:where).with(name: 'repo.git').and_return([repo])
      user.should_receive(:check_access).with(repo, :write).and_return(false)
      Kernel.should_not_receive(:exec).with("git-receive-pack 'folder/repo.git'")
      Gritano::CLI::Console::Git.start %w{git:receive:pack repo.git}
    end

    it "should execute git-upload-pack if the user has read access" do
      user = double('User')
      repo = double('Repository')
      Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
      Gritano::Core::Repository.should_receive(:where).with(name: 'repo.git').and_return([repo])
      user.should_receive(:check_access).with(repo, :read).and_return(true)
      repo.should_receive(:full_path).and_return('folder/repo.git')
      Kernel.should_receive(:exec).with("git-upload-pack 'folder/repo.git'")
      Gritano::CLI::Console::Git.start %w{git:upload:pack repo.git}
    end

    it "should not execute git-upload-pack if the user has not read access" do
      user = double('User')
      repo = double('Repository')
      Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
      Gritano::Core::Repository.should_receive(:where).with(name: 'repo.git').and_return([repo])
      user.should_receive(:check_access).with(repo, :read).and_return(false)
      Kernel.should_not_receive(:exec).with("git-upload-pack 'folder/repo.git'")
      Gritano::CLI::Console::Git.start %w{git:upload:pack repo.git}
    end
  end
end
