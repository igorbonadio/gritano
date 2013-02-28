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
    
    it "should raise an NotImplementedError if on_add is not overrided" do
      lambda { Plugin.new.on_add }.should raise_error NotImplementedError
    end
    
    it "should raise an NotImplementedError if on_remove is not overrided" do
      lambda { Plugin.new.on_remove }.should raise_error NotImplementedError
    end
    
  end
end