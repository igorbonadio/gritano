module Gritano
  class Key < ActiveRecord::Base
    validates :name, :key, presence: true

    belongs_to :user

    def self.authorized_keys
      authorized_keys = ""
      keys = Key.find(:all)
      keys.each do |k|
        user_key = k.key
        unless k.key[-1] == "\n"
          user_key = user_key + "\n"
        end
        authorized_keys += "command=\"gritano-check #{k.user.login}\" #{user_key}"
      end
      return authorized_keys
    end
  end
end
