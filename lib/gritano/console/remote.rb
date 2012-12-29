module Gritano
  module Console
    class Remote < Base

      def initialize(stdin = STDIN, home_dir = Etc.getpwuid.dir, repo_path = Etc.getpwuid.dir)
        @stdin = stdin
        @home_dir = home_dir
        @repo_path = repo_path
        @ssh_path = File.join(@home_dir, '.ssh')
        @executor = Executor.new(@stdin, @home_dir, @repo_path)
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
        [true, Remote.help]
      end
      
      add_command "repo:list" do |args|
        login, = args
        @executor.execute(["user:repo:list"] + [login])
      end
      
      add_command "key:list" do |args|
        login, = args
        @executor.execute(["user:key:list"] + [login])
      end
      
      add_command "key:add", "keyname < key.pub" do |args|
        keyname, login = args
        @executor.execute(["user:key:add"] + [login, keyname])
      end
      
      add_command "key:rm", "keyname" do |args|
        keyname, login = args
        @executor.execute(["user:key:rm"] + [login, keyname])
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
            @executor.execute([meth] + params)
          else
            [false, "access denied"]
          end
        elsif meth.to_s =~ /^git-receive-pack/
          repo, login = args[0]
          Kernel.exec "git-receive-pack #{repo(repo).full_path}"
        elsif meth.to_s =~ /^git-upload-pack/
          repo, login = args[0]
          Kernel.exec "git-upload-pack #{repo(repo).full_path}"
        else
          super
        end
      end
      
      def repo(repo)
        repo = repo.gsub("'", '').strip
        ::Gritano::Repository.find_by_name(repo)
      end
      
    end
  end
end
