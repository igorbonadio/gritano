require File.join(ROOT_PATH, 'gritano/console/base')
require File.join(ROOT_PATH, 'gritano/console/executor')
require File.join(ROOT_PATH, 'gritano/console/installer')
require File.join(ROOT_PATH, 'gritano/console/gritano')
require File.join(ROOT_PATH, 'gritano/console/check')

module Gritano
  module Console
    def Console.bin_name(name)
      Base.bin_name = name
      Check.bin_name = name
      Executor.bin_name = name
      Gritano.bin_name = name
      Installer.bin_name = name
    end
  end
end