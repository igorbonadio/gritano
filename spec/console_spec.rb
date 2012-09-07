require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Gritano::Console do
  it "should respond to gritano user add igorbonadio" do
    console = Gritano::Console.new
    console.should_receive(:user_add)
    console.execute("user add igorbonadio".split(' '))
  end
  
  it "should respond to gritano user rm igorbonadio" do
    console = Gritano::Console.new
    console.should_receive(:user_rm)
    console.execute("user rm igorbonadio".split(' '))
  end
  
  it "should respond to gritano repo add tmp/reponame.git" do
    console = Gritano::Console.new
    console.should_receive(:repo_add)
    #Grit::Repo.should_receive(:init_bare).with("tmp/reponame.git")
    console.execute("repo add tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo rm tmp/reponame.git" do
    console = Gritano::Console.new
    console.should_receive(:repo_rm)
    console.execute("repo rm tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo +read igorbonadio tmp/reponame.git" do
    console = Gritano::Console.new
    console.should_receive(:repo_add_read)
    console.execute("repo +read igorbonadio tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo +write igorbonadio tmp/reponame.git" do
    console = Gritano::Console.new
    console.should_receive(:repo_add_write)
    console.execute("repo +write igorbonadio tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo -read igorbonadio tmp/reponame.git" do
    console = Gritano::Console.new
    console.should_receive(:repo_remove_read)
    console.execute("repo -read igorbonadio tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo -write igorbonadio tmp/reponame.git" do
    console = Gritano::Console.new
    console.should_receive(:repo_remove_write)
    console.execute("repo -write igorbonadio tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo rename tmp/reponame.git tmp/newname" do
    console = Gritano::Console.new
    console.should_receive(:repo_rename)
    console.execute("repo rename tmp/reponame.git tmp/newname".split(' '))
  end
end
