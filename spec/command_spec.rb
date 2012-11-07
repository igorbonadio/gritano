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
  
  it 'should interpret key add keyname' do
    command = Gritano::Command.eval("key add keyname")
    command[:access].to_s.should be == "user_cmd"
    command[:command].should be == "+key keyname"
  end
  
  it 'should interpret -key keyname' do
    command = Gritano::Command.eval("key rm keyname")
    command[:access].to_s.should be == "user_cmd"
    command[:command].should be == "-key keyname"
  end
end
