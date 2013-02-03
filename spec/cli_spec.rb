require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  describe CLI do
    it "should execute local commands" do
      console = double()
      console.should_receive(:execute).and_return([true, "ok"])
      Gritano::Console.should_receive(:remote_console).with(false)
      Gritano::Console::Gritano.should_receive(:new).and_return(console)
      CLI.execute(["user:list"])
    end
    
    it "should execute remote commands" do
      console = double()
      console.should_receive(:execute).and_return([true, "ok"])
      Gritano::Console.should_receive(:remote_console).with(true)
      Gritano::Console::Remote.should_receive(:new).and_return(console)
      CLI.check(["repo:list"], "login")
    end
    
    it "should check public keys" do
      Key.should_receive(:find_by_key).and_return(nil)
      CLI.check_pub_key("key", ".")
    end
  end
end