module Gritano
  class Repository < ActiveRecord::Base
    validates :name, presence: true
    validates_uniqueness_of :name
    
    has_many :permissions
    has_many :users, through: :permissions
    
    before_create :create_bare_repo
    after_destroy :destroy_bare_repo
    
    def create_bare_repo
      Grit::Repo.init_bare(full_path)
    end
    
    def destroy_bare_repo
      FileUtils.rm_r(full_path, force: true)
    end
    
    def full_path
      if path
        File.join(path, name)
      else
        name
      end
    end
    
  end
end