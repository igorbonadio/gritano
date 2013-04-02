module Gritano
  class Config
    def initialize(config_file)
      @config_file = config_file
      load
    end

    def load
      unless File.exist?(@config_file)
        File.open(@config_file, "w").close
      end
      @config = YAML::load(File.open(@config_file))
      unless @config
        @config = Hash.new
      end
    end

    def remove(parameter)
      @config.delete(parameter.to_s)
    end

    def save
      File.open(@config_file, "w") do |f|
        f.write(@config.to_yaml)
      end
    end

    def method_missing(name, *args, &block)
      if name[-1] == '='
        @config[name.to_s[0..-2]] = args[0]
      else
        @config[name.to_s]
      end
    end
  end
end