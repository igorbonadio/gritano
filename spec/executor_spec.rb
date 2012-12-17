require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Gritano::Console::Executor do
  
  before(:each) do
    stdin = double()
    stdin.stub(:read).and_return("Your SSHKEY here...")
    @console = Gritano::Console::Executor.new(stdin)
  end
  
  it "should respond to gritano user:add igorbonadio" do
    @console.should_receive(:user_add)
    @console.execute_without_filters("user:add igorbonadio".split(' '))
  end
  
  it "should respond to gritano user:rm igorbonadio" do
    @console.should_receive(:user_rm)
    @console.execute_without_filters("user:rm igorbonadio".split(' '))
  end
  
  it "should respond to gritano user:key:add username keyname < key.pub" do
    @console.should_receive(:user_key_add)
    @console.execute_without_filters("user:key:add igorbonadio keyname".split(' '))
  end
  
  it "should respond to gritano user:key:rm username keyname" do
    @console.should_receive(:user_key_rm)
    @console.execute_without_filters("user:key:rm username keyname".split(' '))
  end
  
  it "should respond to gritano user:list" do
    @console.should_receive(:user_list)
    @console.execute_without_filters("user:list".split(' '))
  end
  
  it "should respond to gritano user:key:list username" do
    @console.should_receive(:user_key_list)
    @console.execute_without_filters("user:key:list username".split(' '))
  end
  
  it "should respond to gritano user:repo:list username" do
    @console.should_receive(:user_repo_list)
    @console.execute_without_filters("user:repo:list username".split(' '))
  end
  
  it "should respond to gritano repo:user:list reponame.git" do
    @console.should_receive(:repo_user_list)
    @console.execute_without_filters("repo:user:list reponame.git".split(' '))
  end
  
  it "should respond to gritano user:admin:add igorbonadio" do
    @console.should_receive(:user_admin_add)
    @console.execute_without_filters("user:admin:add igorbonadio".split(' '))
  end
  
  it "should respond to gritano user:admin:rm igorbonadio" do
    @console.should_receive(:user_admin_rm)
    @console.execute_without_filters("user:admin:rm igorbonadio".split(' '))
  end
  
  it "should respond to gritano repo:add tmp/reponame.git" do
    @console.should_receive(:repo_add)
    @console.execute_without_filters("repo:add tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo:rm tmp/reponame.git" do
    @console.should_receive(:repo_rm)
    @console.execute_without_filters("repo:rm tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo:read:add igorbonadio tmp/reponame.git" do
    @console.should_receive(:repo_read_add)
    @console.execute_without_filters("repo:read:add igorbonadio tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo:write:add igorbonadio tmp/reponame.git" do
    @console.should_receive(:repo_write_add)
    @console.execute_without_filters("repo:write:add igorbonadio tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo:read:rm igorbonadio tmp/reponame.git" do
    @console.should_receive(:repo_read_rm)
    @console.execute_without_filters("repo:read:rm igorbonadio tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo:write:rm igorbonadio tmp/reponame.git" do
    @console.should_receive(:repo_write_rm)
    @console.execute_without_filters("repo:write:rm igorbonadio tmp/reponame.git".split(' '))
  end
  
  it "should respond to gritano repo:list" do
    @console.should_receive(:repo_list)
    @console.execute_without_filters("repo:list".split(' '))
  end
end
