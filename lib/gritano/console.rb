require File.join(ROOT_PATH, 'gritano/console/base')
require File.join(ROOT_PATH, 'gritano/console/executor')
require File.join(ROOT_PATH, 'gritano/console/installer')
require File.join(ROOT_PATH, 'gritano/console/gritano')
require File.join(ROOT_PATH, 'gritano/console/remote')

module Gritano
  module Console
    def Console.remote_console(remote, home_dir = Etc.getpwuid.dir)
      config = Config.new(File.join(home_dir, '.gritano', 'config.yml'))
      if remote
        Base.bin_name = "ssh #{config.ssh_user}@#{config.host_url} admin:"
        Remote.bin_name = "ssh #{config.ssh_user}@#{config.host_url} "
        Executor.bin_name = "ssh #{config.ssh_user}@#{config.host_url} admin:"
        Gritano.bin_name = "ssh #{config.ssh_user}@#{config.host_url} admin:"
        Installer.bin_name = "ssh #{config.ssh_user}@#{config.host_url} admin:"
      else
        Base.bin_name = "gritano "
        Remote.bin_name = "gritano "
        Executor.bin_name = "gritano "
        Gritano.bin_name = "gritano "
        Installer.bin_name = "gritano "
      end
    end
  end
end