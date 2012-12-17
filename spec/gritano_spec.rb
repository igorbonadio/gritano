require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Gritano::Console::Gritano do
  
  before(:each) do
    stdin = double()
    stdin.stub(:read).and_return("Your SSHKEY here...")
    @console = Gritano::Console::Gritano.new(stdin)
  end
  
  it "should respond to gritano version" do
    @console.should_receive(:version)
    @console.execute("version".split(' '))
  end
  
  it "should respond to gritano help" do
    @console.should_receive(:help)
    @console.execute("help".split(' '))
  end
end
