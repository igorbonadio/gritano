require 'thor'

module Gritano
  module CLI
    class Thor < Thor
      def self.define_task(name, description="", &block)
        params = block.parameters.map { |type, name| name.upcase }.join(' ')
        desc("#{name} #{params}".rstrip, description)
        define_method(name.to_sym, &block)
      end
    end
  end
end