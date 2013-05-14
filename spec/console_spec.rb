require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  describe Console do
    it "should setup a local console" do
      FileUtils.rm_rf(File.join("tmp", "config.yml"))
      Etc.getpwuid.stub(:dir).and_return('tmp')
      Console::Base.should_receive(:bin_name=).with("gritano ")
      Console::Remote.should_receive(:bin_name=).with("gritano ")
      Console::Executor.should_receive(:bin_name=).with("gritano ")
      Console::Gritano.should_receive(:bin_name=).with("gritano ")
      Console::Installer.should_receive(:bin_name=).with("gritano ")
      Console.remote_console(false)
    end
    
    it "should setup a remote console" do
      Console::Base.should_receive(:bin_name=).with("ssh undefined@undefined admin:")
      Console::Remote.should_receive(:bin_name=).with("ssh undefined@undefined ")
      Console::Executor.should_receive(:bin_name=).with("ssh undefined@undefined admin:")
      Console::Gritano.should_receive(:bin_name=).with("ssh undefined@undefined admin:")
      Console::Installer.should_receive(:bin_name=).with("ssh undefined@undefined admin:")
      Console.remote_console(true)
    end
  end
end