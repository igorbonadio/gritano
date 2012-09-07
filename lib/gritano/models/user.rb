module Gritano
  class User < ActiveRecord::Base
    validates :login, presence: true
    validates_uniqueness_of :login
  end
end