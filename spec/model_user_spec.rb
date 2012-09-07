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
  
  it 'should add read access to a repository' do
    user = Gritano::User.create(login: 'test')
    repo = Gritano::User.create(login: 'repo')
    user.add_access(repo, :read).should be_true
  end
  
  it 'should add write access to a repository' do
    user = Gritano::User.create(login: 'test')
    repo = Gritano::User.create(login: 'repo')
    user.add_access(repo, :read).should be_true
  end
  
  it 'should not add an wrong type access to a repository' do
    user = Gritano::User.create(login: 'test')
    repo = Gritano::User.create(login: 'repo')
    user.add_access(repo, :wrong).should be_false
  end
  
  it 'should have read access to a repository' do
    user = Gritano::User.create(login: 'test')
    user.create_repository(name: 'gritano')
    user.check_access(Gritano::Repository.find_by_name('gritano'), :read).should be_true
  end
  
  it 'should have write access to a repository' do
    user = Gritano::User.create(login: 'test')
    user.create_repository(name: 'gritano')
    user.check_access(Gritano::Repository.find_by_name('gritano'), :write).should be_true
  end
  
  it 'should not have read access to a repository' do
    user = Gritano::User.create(login: 'test')
    repo = Gritano::Repository.create(name: 'repo')
    user.check_access(repo, :read).should be_false
  end
  
  it 'should not have write access to a repository' do
    user = Gritano::User.create(login: 'test')
    repo = Gritano::Repository.create(name: 'repo')
    user.check_access(repo, :write).should be_false
  end
  
  it 'should not have wrong access to a repository' do
    user = Gritano::User.create(login: 'test')
    repo = Gritano::Repository.create(name: 'repo')
    user.check_access(repo, :wrong).should be_false
  end
end
