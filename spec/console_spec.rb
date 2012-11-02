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
end
