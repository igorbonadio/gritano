module Gritano
  module CLI
    module Console
      class Base < Thor
        include Gritano::CLI::Renderer
        include Gritano::CLI::Helpers
      end
    end
  end
end