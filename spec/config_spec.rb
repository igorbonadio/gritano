require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  describe Config do
    it "should get parameters" do
      config = Config.new(File.join(".gritano", "config.yml"))
      config.ssh.should be == false
    end

    it "should add parameters"
    it "should remove parameters"
    it "should modify parameters"
  end
end