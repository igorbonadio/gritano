module Gritano
  class User < ActiveRecord::Base
    validates :login, presence: true
    validates_uniqueness_of :login
    
    has_many :permissions
    has_many :repositories, through: :permissions
    
    def create_repository(repo)
      repository = Repository.create(repo)
      permission = Permission.new
      permission.user_id = self.id
      permission.repository_id = repository.id
      permission.access = 2
      permission.save
    end
    
    def add_access(repo, access)
      permission = Permission.new
      permission.user_id = self.id
      permission.repository_id = repo.id
      if access == :read
        permission.access = 1
      elsif access == :write
        permission.access = 2
      else
        return false
      end
      permission.save
    end
    
    def check_access(repo, access)
      if access == :read
        return true if Permission.find_by_user_id_and_repository_id_and_access(self.id, repo.id, 1)
        return true if Permission.find_by_user_id_and_repository_id_and_access(self.id, repo.id, 2)
      elsif access == :write
        return true if Permission.find_by_user_id_and_repository_id_and_access(self.id, repo.id, 2)
      end
      return false
    end
  end
end