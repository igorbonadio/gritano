require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Gritano::CLI

  module Console
    class Base < Thor; end
    class Remote < Base; end
    class Local < Base; end
  end

  describe "Config" do
    it "should start a remote terminal app" do
      Gritano::CLI::Console::Remote.should_receive(:start)
      Gritano::CLI.configure { |config| config.remote = true }
    end

    it "should start a local terminal app" do
      Gritano::CLI::Console::Local.should_receive(:start)
      Gritano::CLI.configure { |config| config.remote = false }
    end
  end
end
