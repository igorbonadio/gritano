require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module Gritano::Core
  describe Key do
    before(:all) do
      ActiveRecord::Base.establish_connection(YAML::load(File.open('spec/data/development.yml')))
    end

    it "should generate the authorized_keys file" do
      user = double("User")
      user.stub(:login).and_return('user_login')
      keys = [double("Key#1"), double("key#2")]
      keys[0].stub(:user).and_return(user)
      keys[0].stub(:key).and_return("some_key")
      keys[1].stub(:user).and_return(user)
      keys[1].stub(:key).and_return("some_key")
      Key.stub(:all).and_return(keys)
      Key.authorized_keys.should be == "command=\"gritano-remote user_login\" some_key\ncommand=\"gritano-remote user_login\" some_key"
    end
  end
end
