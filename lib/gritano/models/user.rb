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
      change_access(repo, "add", access)
    end
    
    def remove_access(repo, access)
      change_access(repo, "remove", access)
    end
    
    def change_access(repo, op, access)
      permission = Permission.find_by_user_id_and_repository_id(self.id, repo.id) || Permission.new
      permission.user_id = self.id
      permission.repository_id = repo.id
      if permission.send("#{op}_access", access)
        return permission.save
      else
        return false
      end
    end
    
    def check_access(repo, access)
      permission = Permission.find_by_user_id_and_repository_id(self.id, repo.id)
      return permission.is(access) if permission
      return false
    end
  end
end