module Gritano
  class Ssh < Plugin
    def info
      "Install a patched OpenSSH version used by Gritano that enables SSH lookup for public keys in a database"
    end
  end
end