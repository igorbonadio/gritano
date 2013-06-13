require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Gritano::CLI

  module Console
    class Base < Thor; end
    class Remote < Base; end
    class Local < Base; end
  end

  describe "Config" do

    describe "#remote" do
      it "should start a remote terminal app if the command is a gritano command" do
        Gritano::CLI::Console::Remote.should_receive(:start)
        ARGV[0] = "some:command"
        Gritano::CLI.configure { |config| config.remote = true }
      end

      it "should start a git terminal app if the command is git:receive:pack" do
        Gritano::CLI::Console::Git.should_receive(:start)
        ARGV[0] = "git:receive:pack"
        Gritano::CLI.configure { |config| config.remote = true }
      end

      it "should start a git terminal app if the command is git:upload:pack" do
        Gritano::CLI::Console::Git.should_receive(:start)
        ARGV[0] = "git:upload:pack"
        Gritano::CLI.configure { |config| config.remote = true }
      end
    end

    it "should start a local terminal app" do
      Gritano::CLI::Console::Local.should_receive(:start)
      Gritano::CLI.configure { |config| config.remote = false }
    end
  end
end
