require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  module Console
    describe Installer do
      def create_installer(home)
        FileUtils.rm_rf(File.join(home, ".gritano"))
        stdin = double()
        stdin.stub(:read).and_return("Your SSHKEY here...")
        Installer.new(stdin, home)
      end
      
      it "should prepare the environment" do
        installer = create_installer("tmp")
        installer.should_receive(:create_gritano_dirs)
        installer.should_receive(:create_sqlite_config)
        installer.execute(["setup:prepare"])
      end
      
      it "should install" do
        installer = create_installer("tmp")
        installer.should_receive(:create_database)
        installer.should_receive(:create_authorization_keys)
        installer.execute(["setup:install"])
      end
    end
  end
end