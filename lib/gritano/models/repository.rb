module Gritano
  class Repository < ActiveRecord::Base
    validates :name, presence: true
    validates_uniqueness_of :name
    
    has_many :permissions
    has_many :users, through: :permissions
  end
end