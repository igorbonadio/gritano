require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano::CLI
  describe Console do
    before (:each) do
      Console.stub(:puts)
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
    end
  end
end
