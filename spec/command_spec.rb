require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Gritano::Command do
  it 'should interpret git-receive-pack' do
    command = Gritano::Command.eval("git-receive-pack 'teste.git'")
    command[:access].to_s.should be == "write"
    command[:command].should be == "git-receive-pack"
    command[:repo].to_s.should be == "teste.git"
  end
  
  it 'should interpret git-upload-pack' do
    command = Gritano::Command.eval("git-upload-pack 'teste.git'")
    command[:access].to_s.should be == "read"
    command[:command].should be == "git-upload-pack"
    command[:repo].to_s.should be == "teste.git"
  end
  
  it 'should interpret repos' do
    command = Gritano::Command.eval("repos")
    command[:access].to_s.should be == "user_cmd"
    command[:command].should be == "repos"
  end
  
  it 'should interpret keys' do
    command = Gritano::Command.eval("keys")
    command[:access].to_s.should be == "user_cmd"
    command[:command].should be == "keys"
  end
  
  it 'should interpret addkey keyname' do
    command = Gritano::Command.eval("addkey keyname")
    command[:access].to_s.should be == "user_cmd"
    command[:command].should be == "addkey keyname"
  end
  
  it 'should interpret rmkey keyname' do
    command = Gritano::Command.eval("rmkey keyname")
    command[:access].to_s.should be == "user_cmd"
    command[:command].should be == "rmkey keyname"
  end
end
