module Gritano
  class Key < ActiveRecord::Base
    
    validates :name, :key, presence: true
    validates :name, :uniqueness => { :scope => :user_id, :message => "should happen once per user" }

    belongs_to :user

    def self.config=(cfg)
      @config = cfg
    end

    def self.authorized_keys
      if @config
        unless @config['ssh']
          return generate_authorized_keys
        end
      else
        return generate_authorized_keys
      end
      return ""
    end
    
    def self.generate_authorized_keys
      authorized_keys = ""
      keys = Key.find(:all)
      keys.each do |k|
        user_key = k.key
        unless k.key[-1] == "\n"
          user_key = user_key + "\n"
        end
        authorized_keys += "command=\"gritano-remote #{k.user.login}\" #{user_key}\n"
      end
      return authorized_keys
    end
  end
end
