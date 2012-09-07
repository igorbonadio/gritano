module Gritano
  class User < ActiveRecord::Base
    validates :login, presence: true
    validates_uniqueness_of :login
    
    has_many :permissions
    has_many :repositories, through: :permissions
    
    def add_access(repo, access)
      permission = Permission.new
      permission.user_id = self.id
      permission.repository_id = repo.id
      if access == :read
        permission.access = 0 
      elsif access == :write
        permission.access = 1 if access == :write
      else
        return false
      end
      permission.save
    end
  end
end