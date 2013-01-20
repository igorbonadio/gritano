require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  module Console
    describe Base do
      def create_base(home)
        stdin = double()
        stdin.stub(:read).and_return("Your SSHKEY here...")
        base = Base.new(stdin, home)
      end
      
      it "should define commands" do
        Base.should_receive(:define_method).with("command_name")
        Base.add_command "command:name", "parameters" do end
      end
      
      it "should execute commands" do
        Base.add_command "command:name", "parameters" do end
        base = create_base('.')
        base.should_receive('command_name')
        base.execute(['command:name'])
      end
      
      it "should show a help message" do
        Base.add_command "command:name", "parameters" do end
        Base.help.should == File.open("spec/data/help_command_name.txt").readlines.join.
            gsub('{{VERSION}}', File.open("VERSION").readlines.join)
      end
      
      it "should check if gritano is not installed" do
        FileUtils.rm_rf('tmp\.gritano')
        base = create_base('tmp')
        lambda { base.check_gritano }.should raise_error SystemExit
      end
      
      it "should check if gritano is installed" do
        base = create_base('.')
        lambda { base.check_gritano }.should_not raise_error SystemExit
      end
      
      it "should check if git is not installed" do
        base = create_base('.')
        base.stub(:unknown_command).and_return(true)
        lambda { base.check_git }.should raise_error SystemExit
      end
      
      it "should check if git is installed" do
        base = create_base('.')
        base.stub(:unknown_command).and_return(false)
        lambda { base.check_git }.should_not raise_error SystemExit
      end
      
      it "should check if a command exists" do
        base = create_base('.')
        base.unknown_command('ls').should be_false
        base.unknown_command('qwertyuioplkjhgfdsa').should be_true
      end
      
    end
  end
end