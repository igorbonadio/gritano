require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  module Console
    describe Gritano do
      def create_gritano(home, repo_dir)
        FileUtils.rm_rf(File.join(home, ".gritano"))
        stdin = double()
        stdin.stub(:read).and_return("Your SSHKEY here...")
        Gritano.new(stdin, home, repo_dir)
      end
      
      it "should show the complete help" do
        create_gritano("tmp", "tmp").
          execute(["help"])[1].
            should == File.open("features/data/local_help.txt").readlines.join.
              gsub('{{VERSION}}', File.open("VERSION").readlines.join)
      end
      
      it "should show the version" do
        create_gritano("tmp", "tmp").
          execute(["version"])[1].
            should == "v#{File.open("VERSION").readlines.join}"
      end
    end
  end
end