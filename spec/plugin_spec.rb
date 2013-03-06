require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  describe Plugin do
    it "should have an on_add method" do
      Plugin.new.should respond_to :on_add
    end
    
    it "should have an on_remove method" do
      Plugin.new.should respond_to :on_remove
    end
    
    it "should have an exec method" do
      Plugin.new.should respond_to :exec
    end
    
    it "should have an info method" do
      Plugin.should respond_to :info
    end
    
    it "should raise an NotImplementedError if on_add is not overrided" do
      lambda { Plugin.new.on_add }.should raise_error NotImplementedError
    end
    
    it "should raise an NotImplementedError if on_remove is not overrided" do
      lambda { Plugin.new.on_remove }.should raise_error NotImplementedError
    end
    
    it "should raise an NotImplementedError if info is not overrided" do
      lambda { Plugin.info }.should raise_error NotImplementedError
    end
    
    it "should exec commands" do
      plugin = Plugin.new
      plugin.should_receive(:config_port).with(["2222"])
      plugin.exec("config:port 2222".split(" "))
      
      plugin.should_receive(:start).with([])
      plugin.exec("start".split(" "))
    end
    
    it "should have a ssh pluging" do
      Plugin.list['ssh'][:klass].should be == Ssh
      Plugin.list['ssh'][:installed].call.should be == false
    end
    
    it "should call on_remove when it receives remove" do
      plugin = Plugin.new
      plugin.should_receive(:on_remove)
      plugin.remove
    end
    
    it "should call on_add when it receives add" do
      plugin = Plugin.new
      plugin.should_receive(:on_add)
      plugin.add
    end
   
   it "should not be installed" do
     Plugin.check_install.should be_false
   end
    
  end
end