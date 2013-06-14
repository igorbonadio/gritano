module Gritano
  module Core
    class Key
      after_create :update_authorized_keys

      def update_authorized_keys
        authorized_keys = File.join(Etc.getpwuid.dir, '.ssh/authorized_keys')
        File.open(authorized_keys, "w").write(Key.authorized_keys)
      end

      def self.authorized_keys
        Key.all.map do |key|
          "command=\"gritano-remote #{key.user.login}\" #{key.key}"
        end.join("\n")
      end
    end
  end
end