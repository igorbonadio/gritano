require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Gritano::Command do
  it 'should interpret git-receive-pack' do
    access, repo = Gritano::Command.eval("git-receive-pack 'teste.git'")
    access.to_s.should be == "write"
    repo.to_s.should be == "teste.git"
  end
  
  it 'should interpret git-upload-pack' do
    access, repo = Gritano::Command.eval("git-upload-pack 'teste.git'")
    access.to_s.should be == "read"
    repo.to_s.should be == "teste.git"
  end
end
