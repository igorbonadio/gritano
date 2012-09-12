require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Gritano::Key do
  it 'should have a name' do
    key = Gritano::Key.new(key: "key")
    key.should be_invalid
  end

  it 'should have a key' do
    key = Gritano::Key.new(name: "name")
    key.should be_invalid
  end

  it 'should generate authorized_keys file' do
    Gritano::User.create(login: 'login').keys.create(key: "key", name: "name")
    Gritano::Key.authorized_keys.should match /^command=/
  end
end
