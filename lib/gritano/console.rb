require File.join(ROOT_PATH, 'gritano/console/base')
require File.join(ROOT_PATH, 'gritano/console/executor')
require File.join(ROOT_PATH, 'gritano/console/installer')
require File.join(ROOT_PATH, 'gritano/console/gritano')
require File.join(ROOT_PATH, 'gritano/console/remote')

module Gritano
  module Console
    def Console.remote_console(remote)
      if remote
        Base.bin_name = "ssh #{::Gritano::Ssh.servername} admin:"
        Remote.bin_name = "ssh #{::Gritano::Ssh.servername} "
        Executor.bin_name = "ssh #{::Gritano::Ssh.servername} admin:"
        Gritano.bin_name = "ssh #{::Gritano::Ssh.servername} admin:"
        Installer.bin_name = "ssh #{::Gritano::Ssh.servername} admin:"
        Plugin.bin_name = "ssh #{::Gritano::Ssh.servername} admin:"
      else
        Base.bin_name = "gritano "
        Remote.bin_name = "gritano "
        Executor.bin_name = "gritano "
        Gritano.bin_name = "gritano "
        Installer.bin_name = "gritano "
        Plugin.bin_name = "gritano "
      end
    end
  end
end