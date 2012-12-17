require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Gritano::Console::Installer do
  
  before(:each) do
    @console = Gritano::Console::Installer.new
  end
  
  it "should respond to gritano setup:prepare" do
    @console.should_receive(:setup_prepare)
    @console.execute("setup:prepare".split(' '))
  end
  
  it "should respond to gritano setup:install" do
    @console.should_receive(:setup_install)
    @console.execute("setup:install".split(' '))
  end
end
