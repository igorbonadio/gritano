require 'thor'

module Gritano
  module CLI
    class Thor < Thor
      def self.define_task(name, description="", &block)
        params = block.parameters.map { |type, name| name.upcase }.join(' ')
        desc("#{name} #{params}".rstrip, description)
        proc = Proc.new do |*params|
          ActiveRecord::Base.establish_connection(YAML::load(File.open(File.join(File.dirname(__FILE__), '../../spec/development.yml'))))
          block.call(*params) 
        end
        define_method(name.to_sym, proc)
      end
    end
  end
end