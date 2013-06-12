require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module Gritano::CLI::Console
  describe Remote do

    before(:each) do
      $stdout.stub(:puts)
      $stdin.stub(:readlines).and_return(['some pubkey'])
      ActiveRecord::Base.stub(:establish_connection)
      YAML.stub(:load)
      Gritano::CLI::Config.remote_user = "user_login"
    end

    it "should list user's repositories" do
      user = double('User')
      repos = double('Repositories')
      user.should_receive(:repositories).and_return(repos)
      repos.should_receive(:order).with(:name).and_return([])
      Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
      Gritano::CLI::Console::Remote.start %w{repo:list}
    end

    it "should list user's keys ordered by name" do
      user = double('User')
      keys = double('Keys')
      user.should_receive(:keys).and_return(keys)
      keys.should_receive(:order).with(:name).and_return([])
      Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
      Gritano::CLI::Console::Remote.start %w{key:list}
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
      Gritano::CLI::Console::Remote.start %w{key:add user_key}
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
      Gritano::CLI::Console::Remote.start %w{key:rm user_key}
    end
  end
end
