require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Gritano::Repository do
  it 'should have a name' do
    repo = Gritano::Repository.new
    repo.should be_invalid
    repo = Gritano::Repository.new(name: 'name')
    repo.should be_valid
  end
  
  it 'should have a unique name' do
    repo1 = Gritano::Repository.create(name: 'test')
    repo2 = Gritano::Repository.new(name: 'test')
    repo2.should be_invalid
  end
end
