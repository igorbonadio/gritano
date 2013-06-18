require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Gritano::CLI
  describe Config do
    it "should have default parameters" do
      File.stub(:open)
      Config.should_receive(:database_connection=)
      Config.should_receive(:repository_path=)
      Config.should_receive(:remote_ssh_prefix=)
      Gritano::CLI.configure {}
    end
  end
end
