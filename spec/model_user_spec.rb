require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Gritano::User do
  it 'should have a login' do
    user = Gritano::User.new
    user.should be_invalid
    user = Gritano::User.new(login: 'login')
    user.should be_valid
  end
  
  it 'should have a unique login' do
    user1 = Gritano::User.create(login: 'test')
    user2 = Gritano::User.new(login: 'test')
    user2.should be_invalid
  end
end
