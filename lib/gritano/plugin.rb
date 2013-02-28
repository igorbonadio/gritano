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
    
    def self.list
      @subclass
    end
    
    def self.inherited(subclass)
      if @subclass
        @subclass << subclass
      else
        @subclass = [subclass]
      end
    end
    
  end
end

require File.join(ROOT_PATH, 'gritano/plugin/ssh')