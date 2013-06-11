require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Gritano::CLI
  class Console < Thor
  end

  describe "Config" do
    it "should start a terminal app" do
      Gritano::CLI::Console.should_receive(:start)
      Gritano::CLI.configure {}
    end
  end
end
