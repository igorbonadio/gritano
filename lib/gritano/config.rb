module Gritano
  class Config
    def initialize(config_file)
      @config_file = config_file
      load
    end

    def load
      @config = YAML::load(File.open(@config_file))
    end

    def method_missing(name, *args, &block)
      @config[name.to_s]
    end
  end
end