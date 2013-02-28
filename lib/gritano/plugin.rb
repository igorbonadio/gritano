module Gritano
  class Plugin
    def on_add
      raise NotImplementedError
    end
    
    def on_remove
      raise NotImplementedError
    end
    
    def exec
    end
  end
end