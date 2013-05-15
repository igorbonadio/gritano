require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  describe Console do
    it "should setup a local console" do
      Console::Base.should_receive(:bin_name=).with("gritano ")
      Console::Remote.should_receive(:bin_name=).with("gritano ")
      Console::Executor.should_receive(:bin_name=).with("gritano ")
      Console::Gritano.should_receive(:bin_name=).with("gritano ")
      Console::Installer.should_receive(:bin_name=).with("gritano ")
      FileUtils.rm_rf(File.join("tmp", ".gritano"))
      FileUtils.mkdir(File.join('tmp', '.gritano'))
      Console.remote_console(false, 'tmp')
    end
    
    it "should setup a remote console" do
      Console::Base.should_receive(:bin_name=).with("ssh undefined@undefined admin:")
      Console::Remote.should_receive(:bin_name=).with("ssh undefined@undefined ")
      Console::Executor.should_receive(:bin_name=).with("ssh undefined@undefined admin:")
      Console::Gritano.should_receive(:bin_name=).with("ssh undefined@undefined admin:")
      Console::Installer.should_receive(:bin_name=).with("ssh undefined@undefined admin:")
      FileUtils.rm_rf(File.join("tmp", ".gritano"))
      FileUtils.mkdir(File.join('tmp', '.gritano'))
      Console.remote_console(true, 'tmp')
    end
  end
end