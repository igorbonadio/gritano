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
  
  it "should respond to gritano repo add igorbonadio reponame" do
    console = Gritano::Console.new
    console.should_receive(:repo_add)
    console.execute("repo add igorbonadio reponame".split(' '))
  end
  
  it "should respond to gritano repo rm igorbonadio reponame" do
    console = Gritano::Console.new
    console.should_receive(:repo_rm)
    console.execute("repo rm igorbonadio reponame".split(' '))
  end
  
  it "should respond to gritano repo +read igorbonadio reponame" do
    console = Gritano::Console.new
    console.should_receive(:repo_add_read)
    console.execute("repo +read igorbonadio reponame".split(' '))
  end
  
  it "should respond to gritano repo +write igorbonadio reponame" do
    console = Gritano::Console.new
    console.should_receive(:repo_add_write)
    console.execute("repo +write igorbonadio reponame".split(' '))
  end
  
  it "should respond to gritano repo -read igorbonadio reponame" do
    console = Gritano::Console.new
    console.should_receive(:repo_remove_read)
    console.execute("repo -read igorbonadio reponame".split(' '))
  end
  
  it "should respond to gritano repo -write igorbonadio reponame" do
    console = Gritano::Console.new
    console.should_receive(:repo_remove_write)
    console.execute("repo -write igorbonadio reponame".split(' '))
  end
  
  it "should respond to gritano repo rename reponame newname" do
    console = Gritano::Console.new
    console.should_receive(:repo_rename)
    console.execute("repo rename reponame newname".split(' '))
  end
end
