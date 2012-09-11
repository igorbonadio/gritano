module Gritano
  class Repository < ActiveRecord::Base
    validates :name, presence: true
    validates_uniqueness_of :name
    
    has_many :permissions
    has_many :users, through: :permissions
    
    before_create :create_bare_repo
    
    def create_bare_repo
      if path
        Grit::Repo.init_bare(File.join(path, name))
      else
        Grit::Repo.init_bare(name)
      end
    end
    
  end
end