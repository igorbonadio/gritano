require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module Gritano::CLI::Console
  describe Local do

    before(:each) do
      $stdout.stub(:puts)
      $stdin.stub(:readlines).and_return(['some pubkey'])
      ActiveRecord::Base.stub(:establish_connection)
      File.stub(:open)
      YAML.stub(:load)
    end

    def model_array(model_name)
      users = []
      users.stub(:model).and_return(users)
      users.stub(:name).and_return(model_name)
      users
    end

    describe "#user" do
      it "should list all users ordered by login" do
        Gritano::Core::User.should_receive(:order).with(:login).and_return(model_array("Gritano::Core::User"))
        Gritano::CLI::Console::Local.start %w{user:list}
      end

      it "should add a user" do
        user = double("User")
        user.should_receive(:save).and_return(true)
        Gritano::Core::User.should_receive(:new).with(login: 'user_login').and_return(user)
        Gritano::CLI::Console::Local.start %w{user:add user_login}
      end

      it "should remove an existing user" do
        user = double("User")
        user.should_receive(:destroy)
        Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
        Gritano::CLI::Console::Local.start %w{user:rm user_login}
      end

      it "should update the admin attribute of an existing user" do
        user = double("User")
        user.should_receive(:update_attributes).with({"admin" => "true"})
        Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
        Gritano::CLI::Console::Local.start %w{user:update user_login --admin=true}
      end

      describe "#keys" do
        it "should list user's keys ordered by name" do
          user = double("User")
          keys = double("Key")
          keys.stub(:count).and_return(10)
          keys.stub(:each)
          Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
          user.should_receive(:keys).and_return(keys)
          keys.should_receive(:order).with(:name).and_return(keys)
          Gritano::CLI::Console::Local.start %w{user:key:list user_login}
        end

        it "should add user's key" do
          user = double("User")
          keys = double("Key")
          keys.stub(:name).and_return("Key")
          key = double("Key")
          Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
          user.should_receive(:keys).and_return(keys)
          keys.should_receive(:new).with(name: 'user_key', key: 'some pubkey').and_return(key)
          key.should_receive(:save).and_return(true)
          Gritano::CLI::Console::Local.start %w{user:key:add user_login user_key}
        end

        it "should remove user's key" do
          user = double("User")
          keys = [double("Key")]
          keys.stub(:name).and_return("Key")
          key = double("Key")
          Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
          user.should_receive(:keys).and_return(keys)
          keys.should_receive(:where).with(name: 'user_key').and_return([key])
          key.should_receive(:destroy)
          Gritano::CLI::Console::Local.start %w{user:key:rm user_login user_key}
        end
      end
    end

    describe "#repo" do
      it "should list repositories ordered by name" do
        Gritano::Core::Repository.should_receive(:order).with(:name).and_return(model_array("Gritano::Core::Repository"))
        Gritano::CLI::Console::Local.start %w{repo:list}
      end

      it "should add a new repository" do
        repo = double("Repository")
        repo.should_receive(:save).and_return(true)
        Gritano::CLI::Config.repository_path = "tmp"
        Gritano::Core::Repository.should_receive(:new).with(name: 'repo.git', path: 'tmp').and_return(repo)
        Gritano::CLI::Console::Local.start %w{repo:add repo.git}
      end

      it "should remove a existing repository" do
        repo = double("Repository")
        repo.should_receive(:destroy)
        Gritano::Core::Repository.should_receive(:where).with(name: 'repo.git').and_return([repo])
        Gritano::CLI::Console::Local.start %w{repo:rm repo.git}
      end

      it "should add read access to a repository" do
        repo = double("Repository")
        user = double("User")
        Gritano::Core::Repository.should_receive(:where).with(name: 'repo.git').and_return([repo])
        Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
        user.should_receive(:add_access).with(repo, :read).and_return(true)
        Gritano::CLI::Console::Local.start %w{repo:read:add repo.git user_login}
      end

      it "should remove read access from a repository" do
        repo = double("Repository")
        user = double("User")
        Gritano::Core::Repository.should_receive(:where).with(name: 'repo.git').and_return([repo])
        Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
        user.should_receive(:remove_access).with(repo, :read).and_return(true)
        Gritano::CLI::Console::Local.start %w{repo:read:rm repo.git user_login}
      end

      it "should add write access to a repository" do
        repo = double("Repository")
        user = double("User")
        Gritano::Core::Repository.should_receive(:where).with(name: 'repo.git').and_return([repo])
        Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
        user.should_receive(:add_access).with(repo, :write).and_return(true)
        Gritano::CLI::Console::Local.start %w{repo:write:add repo.git user_login}
      end

      it "should remove write access from a repository" do
        repo = double("Repository")
        user = double("User")
        Gritano::Core::Repository.should_receive(:where).with(name: 'repo.git').and_return([repo])
        Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
        user.should_receive(:remove_access).with(repo, :write).and_return(true)
        Gritano::CLI::Console::Local.start %w{repo:write:rm repo.git user_login}
      end

      it "should list repository's users ordered by login" do
        repo = double("Repository")
        users = [double("User")]
        user = double("User")
        Gritano::Core::Repository.should_receive(:where).with(name: 'repo.git').and_return([repo])
        repo.should_receive(:users).and_return(users)
        users.should_receive(:order).with(:login).and_return([user])
        user.should_receive(:access).with(repo)
        user.stub(:login)
        Gritano::CLI::Console::Local.start %w{repo:user:list repo.git}
      end
    end
  end
end
