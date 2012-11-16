require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Gritano::Console do
  
  before(:each) do
    stdin = double()
    stdin.stub(:read).and_return("Your SSHKEY here...")
    @console = Gritano::Console.new(stdin)
  end
  
  it "should respond to gritano user add igorbonadio" do
    @console.should_receive(:user_add)
    @console.execute("user add igorbonadio".split(' '))
  end
  
  it "should respond to gritano user rm igorbonadio" do
    @console.should_receive(:user_rm)
    @console.execute("user rm igorbonadio".split(' '))
  end
  
  it "should respond to gritano user addkey username keyname < key.pub" do
    @console.should_receive(:user_addkey)
    @console.execute("user addkey igorbonadio keyname".split(' '))
  end
  
  it "should respond to gritano user rmkey username keyname" do
    @console.should_receive(:user_rmkey)
    @console.execute("user rmkey username keyname".split(' '))
  end
  
  it "should respond to gritano user list" do
    @console.should_receive(:user_list)
    @console.execute("user list".split(' '))
  end
  
  it "should respond to gritano user keys username" do
    @console.should_receive(:user_keys)
    @console.execute("user keys username".split(' '))
  end
  
  it "should respond to gritano user repos username" do
    @console.should_receive(:user_repos)
    @console.execute("user repos username".split(' '))
  end
  
  it "should respond to gritano repo add tmp/reponame.git" do
    @console.should_receive(:repo_add)
    @console.execute("repo add tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo rm tmp/reponame.git" do
    @console.should_receive(:repo_rm)
    @console.execute("repo rm tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo addread igorbonadio tmp/reponame.git" do
    @console.should_receive(:repo_addread)
    @console.execute("repo addread igorbonadio tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo addwrite igorbonadio tmp/reponame.git" do
    @console.should_receive(:repo_addwrite)
    @console.execute("repo addwrite igorbonadio tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo rmread igorbonadio tmp/reponame.git" do
    @console.should_receive(:repo_rmread)
    @console.execute("repo rmread igorbonadio tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo rmwrite igorbonadio tmp/reponame.git" do
    @console.should_receive(:repo_rmwrite)
    @console.execute("repo rmwrite igorbonadio tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo list" do
    @console.should_receive(:repo_list)
    @console.execute("repo list".split(' '))
  end
  
  it "should respond to gritano repo users reponame.git" do
    @console.should_receive(:repo_users)
    @console.execute("repo users reponame.git".split(' '))
  end
end
