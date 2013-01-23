require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  describe Console do
    it "should setup a local console" do
      Console::Base.should_receive(:bin_name=).with("gritano ")
      Console::Remote.should_receive(:bin_name=).with("gritano ")
      Console::Executor.should_receive(:bin_name=).with("gritano ")
      Console::Gritano.should_receive(:bin_name=).with("gritano ")
      Console::Installer.should_receive(:bin_name=).with("gritano ")
      Console.remote_console(false)
    end
    
    it "should setup a remote console" do
      Console::Base.should_receive(:bin_name=).with("ssh git@host.com admin:")
      Console::Remote.should_receive(:bin_name=).with("ssh git@host.com ")
      Console::Executor.should_receive(:bin_name=).with("ssh git@host.com admin:")
      Console::Gritano.should_receive(:bin_name=).with("ssh git@host.com admin:")
      Console::Installer.should_receive(:bin_name=).with("ssh git@host.com admin:")
      Console.remote_console(true)
    end
  end
end