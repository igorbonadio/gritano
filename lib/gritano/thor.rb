require 'thor'

module Gritano
  module CLI
    class Thor < Thor
      def self.define_task(name, description="", &block)
        params = block.parameters.map { |type, name| name.upcase }.join(' ')
        desc("#{name} #{params}".rstrip, description)
        bf = before_filters[name]
        define_method(name.to_sym) do |*params|
          instance_eval(&bf) if bf
          instance_exec(*params, &block)
        end
      end

      def self.before(methods, &block)
        methods.each do |method|
          before_filters[method] = block
        end
      end

      def self.before_filters
        @before_filters ||= {}
      end
    end
  end
end