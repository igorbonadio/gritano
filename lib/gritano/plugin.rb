module Gritano
  class Plugin
    def on_add
      raise NotImplementedError
    end
    
    def on_remove
      raise NotImplementedError
    end
    
    def exec(cmd)
      method = cmd[0].split(':').join('_')
      params = cmd[1..-1]
      send(method, params)
    end
  end
end