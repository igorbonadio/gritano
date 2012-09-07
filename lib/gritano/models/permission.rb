module Gritano
  class Permission < ActiveRecord::Base
    belongs_to :user
    belongs_to :repository
    
    def add_access(access)
      if access == :read
        self.access = 1 | (self.access || 0)
      elsif access == :write
        self.access = 2 | (self.access || 0)
      else
        return false
      end
      return true
    end
    
    def remove_access(access)
      if access == :read
        self.access = (self.access || 0) & (~1)
      elsif access == :write
        self.access = (self.access || 0) & (~2)
      else
        return false
      end
      return true
    end
  end
end