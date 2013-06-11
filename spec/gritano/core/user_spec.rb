require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module Gritano::Core
  describe User do
    before(:all) do
      ActiveRecord::Base.establish_connection(YAML::load(File.open('spec/data/development.yml')))
    end

    describe "#access" do
      it "should return a string that represents a read access" do
        repo = double("Repo")
        user = User.new
        user.should_receive(:check_access).with(repo, :read).and_return(true)
        user.should_receive(:check_access).with(repo, :write).and_return(false)
        user.access(repo).should be == "read"
      end

      it "should return a string that represents a write access" do
        repo = double("Repo")
        user = User.new
        user.should_receive(:check_access).with(repo, :read).and_return(false)
        user.should_receive(:check_access).with(repo, :write).and_return(true)
        user.access(repo).should be == "write"
      end

      it "should return a string that represents a read and write access" do
        repo = double("Repo")
        user = User.new
        user.should_receive(:check_access).with(repo, :read).and_return(true)
        user.should_receive(:check_access).with(repo, :write).and_return(true)
        user.access(repo).should be == "read+write"
      end

      it "should return a null string when user doens't have access to the repository" do
        repo = double("Repo")
        user = User.new
        user.should_receive(:check_access).with(repo, :read).and_return(false)
        user.should_receive(:check_access).with(repo, :write).and_return(false)
        user.access(repo).should be == ""
      end
    end
  end
end
