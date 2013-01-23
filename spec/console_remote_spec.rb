require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  module Console
    describe Remote do
      def create_remote(home, repo_dir)
        stdin = double()
        stdin.stub(:read).and_return("Your SSHKEY here...")
        Remote.new(stdin, home, repo_dir)
      end
      
      it "should show a help message" do
        create_remote(".", "tmp").
          execute(["help"])[1].
            should == File.open("features/data/remote_help.txt").readlines.join.
              gsub('{{VERSION}}', File.open("VERSION").readlines.join)
      end
      
      it "should show the version" do
        create_remote(".", "tmp").
          execute(["version"])[1].
            should == "v#{File.open("VERSION").readlines.join}"
      end
      
    end
  end
end