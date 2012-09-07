module Gritano
  class Permission < ActiveRecord::Base
    belongs_to :user
    belongs_to :repository
    
    READ = 1
    WRITE = 2
    
    def add_access(access)
      if access == :read
        self.access = READ | (self.access || 0)
      elsif access == :write
        self.access = WRITE | (self.access || 0)
      else
        return false
      end
      return true
    end
    
    def remove_access(access)
      if access == :read
        self.access = (self.access || 0) & (~ READ)
      elsif access == :write
        self.access = (self.access || 0) & (~ WRITE)
      else
        return false
      end
      return true
    end
    
    def is(access)
      if access == :read
        return (self.access & READ) == READ
      elsif access == :write
        return (self.access & WRITE) == WRITE
      end
    end
  end
end