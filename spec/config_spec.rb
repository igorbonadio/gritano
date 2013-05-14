require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  describe Config do
    it "should get parameters" do
      config = Config.new(File.join(".gritano", "config.yml"))
      config.host_url.should be == "gritano.org"
    end

    it "should add parameters" do
      FileUtils.mkdir_p('tmp')
      if File.exist?(File.join("tmp", "config_test.yml"))
        FileUtils.rm(File.join("tmp", "config_test.yml"))
      end
      config = Config.new(File.join("tmp", "config_test.yml"))
      config.host_url.should be == "undefined"
      config.host_url = "gritano.org"
      config.host_url.should be == "gritano.org"
    end

    it "should remove parameters" do
      FileUtils.mkdir_p('tmp')
      if File.exist?(File.join("tmp", "config_test.yml"))
        FileUtils.rm(File.join("tmp", "config_test.yml"))
      end
      config = Config.new(File.join("tmp", "config_test.yml"))

      config.host_url = "gritano.org"
      config.host_url.should be == "gritano.org"

      config.remove(:host_url)
      config.host_url.should be == "undefined"
    end

    it "should modify parameters" do
      FileUtils.mkdir_p('tmp')
      if File.exist?(File.join("tmp", "config_test.yml"))
        FileUtils.rm(File.join("tmp", "config_test.yml"))
      end
      config = Config.new(File.join("tmp", "config_test.yml"))
      config.host_url.should be == "undefined"
      config.host_url = "gritano.org"
      config.host_url.should be == "gritano.org"
      config.host_url = "host.org"
      config.host_url.should be == "host.org"
    end

    it "should save a config file" do
      FileUtils.mkdir_p('tmp')
      if File.exist?(File.join("tmp", "config_test.yml"))
        FileUtils.rm(File.join("tmp", "config_test.yml"))
      end
      config = Config.new(File.join("tmp", "config_test.yml"))
      config.host_url = "gritano.org"
      config.email = {login: 'igor', smtp: 'smtp.igor.com'}
      config.save

      config2 = Config.new(File.join("tmp", "config_test.yml"))
      config2.host_url.should be == "gritano.org"
      config2.email[:login].should be == "igor"
      config2.email[:smtp].should be == "smtp.igor.com"
    end
  end
end