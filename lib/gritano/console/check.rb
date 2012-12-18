module Gritano
  module Console
    class Check < Base
      def initialize(stdin)
        @stdin = stdin
      end
      
      before_each_command do
        check_git
        check_gritano
        ActiveRecord::Base.establish_connection(
          YAML::load(File.open(File.join(Etc.getpwuid.dir, '.gritano', 'database.yml'))))
      end
      
      add_command "help" do |args|
        [true, Check.help]
      end
      
      add_command "repo:list" do |args|
        login, = args
        executor = Executor.new(@stdin)
        executor.execute(["user:repo:list"] + [login])
      end
      
      add_command "key:list" do |args|
        login, = args
        executor = Executor.new(@stdin)
        executor.execute(["user:key:list"] + [login])
      end
      
      add_command "key:add", "keyname < key.pub" do |args|
        keyname, login = args
        executor = Executor.new(@stdin)
        executor.execute(["user:key:add"] + [login, keyname])
      end
      
      add_command "key:rm", "keyname" do |args|
        keyname, login = args
        executor = Executor.new(@stdin)
        executor.execute(["user:key:rm"] + [login, keyname])
      end
      
      add_command "admin:help" do |args|
        executor = Gritano.new(@stdin)
        executor.execute(["help"])
      end
      
      def method_missing(meth, *args, &block)
        if meth.to_s =~ /^admin/
          user = ::Gritano::User.find_by_login(args[0][-1])
          if user.admin?
            meth = meth.to_s.gsub("admin_", "")
            params = args[0][0..-2]
            executor = Gritano.new(@stdin)
            executor.execute([meth] + params)
          else
            [false, "access denied"]
          end
        elsif meth.to_s =~ /^git-receive-pack/
          cmd = meth.to_s + ' ' + args[0..-2].join(' ')
          exec "git-receive-pack #{File.join(repo(cmd).full_path)}"
        else
          super
        end
      end
      
      def repo(cmd)
        Gritano::Repository.find_by_name(cmd.gsub(/^git-receive-pack/, '').gsub(/^git-upload-pack/, '').gsub("'", '').strip)
      end
      
    end
  end
end
