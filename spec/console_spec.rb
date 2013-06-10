require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano::CLI
  describe Console do
    before (:each) do
      Console.stub(:puts)
      $stdin.stub(:readlines).and_return(['some pubkey'])
    end
    describe "#user" do
      it "should list all users ordered by login" do
        Gritano::Core::User.should_receive(:order).with(:login).and_return([])
        Gritano::CLI::Console.start %w{user:list}
      end

      it "should add a user" do
        user = double("User")
        user.should_receive(:save).and_return(true)
        Gritano::Core::User.should_receive(:new).with(login: 'user_login').and_return(user)
        Gritano::CLI::Console.start %w{user:add user_login}
      end

      it "should remove a existing user" do
        user = double("User")
        user.should_receive(:destroy)
        Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
        Gritano::CLI::Console.start %w{user:rm user_login}
      end

      describe "#keys" do
        it "should list user's keys ordered by name" do
          user = double("User")
          keys = double("Key")
          keys.stub(:count).and_return(10)
          keys.stub(:each)
          Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
          user.should_receive(:keys).twice.and_return(keys)
          keys.should_receive(:order).with(:name).and_return(keys)
          Gritano::CLI::Console.start %w{user:key:list user_login}
        end

        it "should add user's key" do
          user = double("User")
          keys = double("Key")
          key = double("Key")
          Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
          user.should_receive(:keys).and_return(keys)
          keys.should_receive(:new).with(name: 'user_key', key: 'some pubkey').and_return(key)
          key.should_receive(:save).and_return(true)
          Gritano::CLI::Console.start %w{user:key:add user_login user_key}
        end

        it "should remove user's key" do
          user = double("User")
          keys = [double("Key")]
          key = double("Key")
          Gritano::Core::User.should_receive(:where).with(login: 'user_login').and_return([user])
          user.should_receive(:keys).and_return(keys)
          keys.should_receive(:where).with(name: 'user_key').and_return([key])
          key.should_receive(:destroy)
          Gritano::CLI::Console.start %w{user:key:rm user_login user_key}
        end
      end
    end
  end
end
