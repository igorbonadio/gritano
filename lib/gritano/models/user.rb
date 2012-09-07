module Gritano
  class User < ActiveRecord::Base
    validates :login, presence: true
    validates_uniqueness_of :login
    
    has_many :permissions
    has_many :repositories, through: :permissions
    
    def create_repository(repo)
      repository = Repository.create(repo)
      add_access(repository, :read)
      add_access(repository, :write)
    end
    
    def add_access(repo, access)
      permission = Permission.find_by_user_id_and_repository_id(self.id, repo.id) || Permission.new
      permission.user_id = self.id
      permission.repository_id = repo.id
      if access == :read
        permission.access = 1 | (permission.access || 0)
      elsif access == :write
        permission.access = 2 | (permission.access || 0)
      else
        return false
      end
      permission.save
    end
    
    def remove_access(repo, access)
      permission = Permission.find_by_user_id_and_repository_id(self.id, repo.id) || Permission.new
      permission.user_id = self.id
      permission.repository_id = repo.id
      if access == :read
        permission.access = (permission.access || 0) & (~1)
      elsif access == :write
        permission.access = (permission.access || 0) & (~2)
      else
        return false
      end
      permission.save
    end
    
    def check_access(repo, access)
      permission = Permission.find_by_user_id_and_repository_id(self.id, repo.id)
      if permission
        if access == :read
          return (permission.access & 1) == 1
        elsif access == :write
          return (permission.access & 2) == 2
        end
      end
      return false
    end
  end
end