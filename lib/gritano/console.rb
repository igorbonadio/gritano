require File.join(File.dirname(__FILE__), 'console/remote_console')
require File.join(File.dirname(__FILE__), 'console/local_console')

module Gritano
  module CLI
    class Console < Thor
      include Gritano::CLI::Renderer
      include Gritano::CLI::Helpers
    end
  end
end