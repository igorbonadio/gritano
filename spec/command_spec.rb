require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Gritano::Command do
  it 'should interpret git-receive-pack' do
    access, git_command, repo = Gritano::Command.eval("git-receive-pack 'teste.git'")
    access.to_s.should be == "write"
    git_command.should be == "git-receive-pack"
    repo.to_s.should be == "teste.git"
  end
  
  it 'should interpret git-upload-pack' do
    access, git_command, repo = Gritano::Command.eval("git-upload-pack 'teste.git'")
    access.to_s.should be == "read"
    git_command.should be == "git-upload-pack"
    repo.to_s.should be == "teste.git"
  end
end
