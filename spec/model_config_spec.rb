require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  describe Config do
    it "should have a ssh configuration" do
      config = YAML::load(File.open(File.join('.gritano', 'config.yml')))
      config['ssh'].should be_false
    end
  end
end