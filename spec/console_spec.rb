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
  
  it "should respond to gritano user +key username keyname < key.pub" do
    @console.should_receive(:user_add_key)
    @console.execute("user +key igorbonadio keyname".split(' '))
  end
  
  it "should respond to gritano user -key username keyname" do
    @console.should_receive(:user_remove_key)
    @console.execute("user -key username keyname".split(' '))
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
  
  it "should respond to gritano repo +read igorbonadio tmp/reponame.git" do
    @console.should_receive(:repo_add_read)
    @console.execute("repo +read igorbonadio tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo +write igorbonadio tmp/reponame.git" do
    @console.should_receive(:repo_add_write)
    @console.execute("repo +write igorbonadio tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo -read igorbonadio tmp/reponame.git" do
    @console.should_receive(:repo_remove_read)
    @console.execute("repo -read igorbonadio tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo -write igorbonadio tmp/reponame.git" do
    @console.should_receive(:repo_remove_write)
    @console.execute("repo -write igorbonadio tmp/reponame.git".split(' '))
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
