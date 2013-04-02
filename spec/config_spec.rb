require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  describe Config do
    it "should get parameters" do
      config = Config.new(File.join(".gritano", "config.yml"))
      config.ssh.should be == false
    end

    it "should add parameters" do
      if File.exist?(File.join("tmp", "config_test.yml"))
        FileUtils.rm(File.join("tmp", "config_test.yml"))
      end
      config = Config.new(File.join("tmp", "config_test.yml"))
      config.ssh.should be == nil
      config.ssh = true
      config.ssh.should be == true
    end

    it "should remove parameters" do
      if File.exist?(File.join("tmp", "config_test.yml"))
        FileUtils.rm(File.join("tmp", "config_test.yml"))
      end
      config = Config.new(File.join("tmp", "config_test.yml"))

      config.ssh = true
      config.ssh.should be == true

      config.remove(:ssh)
      config.ssh.should be == nil
    end

    it "should modify parameters" do
      if File.exist?(File.join("tmp", "config_test.yml"))
        FileUtils.rm(File.join("tmp", "config_test.yml"))
      end
      config = Config.new(File.join("tmp", "config_test.yml"))
      config.ssh.should be == nil
      config.ssh = true
      config.ssh.should be == true
      config.ssh = false
      config.ssh.should be == false
    end
  end
end