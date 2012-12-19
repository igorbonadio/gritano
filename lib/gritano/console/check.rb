module Gritano
  module Console
    class Check < Base

      def initialize(stdin = STDIN, home_dir = Etc.getpwuid.dir)
        @stdin = stdin
        @executor = Executor.new(@stdin)
        @home_dir = home_dir
        super(@stdin, @home_dir)
      end
      
      before_each_command do
        check_git
        check_gritano
        ActiveRecord::Base.establish_connection(
          YAML::load(File.open(File.join(@home_dir, '.gritano', 'database.yml'))))
      end
      
      add_command "version" do |argv|
        version = "v#{File.open(File.join(File.dirname(__FILE__), '..', '..', '..', 'VERSION')).readlines.join}"
        [true, version]
      end
      
      add_command "help" do |args|
        [true, Check.help]
      end
      
      add_command "repo:list" do |args|
        login, = args
        if @desable_filters
          @executor.execute_without_filters(["user:repo:list"] + [login])
        else
          @executor.execute(["user:repo:list"] + [login])
        end
      end
      
      add_command "key:list" do |args|
        login, = args
        if @desable_filters
          @executor.execute_without_filters(["user:key:list"] + [login])
        else
          @executor.execute(["user:key:list"] + [login])
        end
      end
      
      add_command "key:add", "keyname < key.pub" do |args|
        keyname, login = args
        if @desable_filters
          @executor.execute_without_filters(["user:key:add"] + [login, keyname])
        else
          @executor.execute(["user:key:add"] + [login, keyname])
        end
      end
      
      add_command "key:rm", "keyname" do |args|
        keyname, login = args
        if @desable_filters
          @executor.execute_without_filters(["user:key:rm"] + [login, keyname])
        else
          @executor.execute(["user:key:rm"] + [login, keyname])
        end
      end
      
      add_command "admin:help" do |args|
        gritano = Gritano.new(@stdin)
        gritano.execute(["help"])
      end
      
      def method_missing(meth, *args, &block)
        if meth.to_s =~ /^admin/
          user = ::Gritano::User.find_by_login(args[0][-1])
          if user.admin?
            meth = meth.to_s[6..-1]
            params = args[0][0..-2]
            if @desable_filters
              @executor.execute_without_filters([meth] + params)
            else
              @executor.execute([meth] + params)
            end
          else
            [false, "access denied"]
          end
        elsif meth.to_s =~ /^git-receive-pack/
          repo, login = args[0]
          exec "git-receive-pack #{repo(repo).full_path}"
        elsif meth.to_s =~ /^git-upload-pack/
          repo, login = args[0]
          exec "git-upload-pack #{repo(repo).full_path}"
        else
          super
        end
      end
      
      def repo(repo)
        repo = repo.gsub("'", '').strip
        ::Gritano::Repository.find_by_name(repo)
      end

      def desable_filters
        @desable_filters = true
      end
      
    end
  end
end
