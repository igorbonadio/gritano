module Gritano
  module Core
    class User
      def access(repo)
        access = []
        access << 'read' if check_access(repo, :read)
        access << 'write' if check_access(repo, :write)
        "#{access.join('+')}"
      end
    end
  end
end