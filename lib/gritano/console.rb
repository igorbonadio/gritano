module Gritano
  module CLI
    class Console < Thor

      define_task("user:list", "list all gritano users") do
        render_table(Gritano::Core::User.order(:login), :login, :admin)
      end

      define_task("user:add", "add a gritano user") do |login|
        create_model(Gritano::Core::User, login: login)
      end

      define_task("user:rm", "remove a gritano user") do |login|
        destroy_model(Gritano::Core::User, login: login)
      end

      method_option :admin, :aliases => "-a", :desc => "change admin status of a user"
      define_task("user:update", "update user information") do |login|
        user = Gritano::Core::User.where(login: login).first
        if user
          if options[:admin] == "true"
            user.admin = true
          elsif options[:admin] == "false"
            user.admin = false
          else
            puts "invalid admin parameter"
            return
          end
          if user.save
            puts "done"
          else
            puts "an error occurred"
          end
        else
          puts "user doens't exist."
        end
      end

      define_task("user:key:list", "list all user's keys") do |login|
        use_if_not_nil Gritano::Core::User.where(login: login).first do |user|
          render_table(user.keys.order(:name), :name)
        end
      end

      define_task("user:key:add", "add a user's key") do |login, key_name|
        use_if_not_nil Gritano::Core::User.where(login: login).first do |user|
          create_model(user.keys, name: key_name, key: $stdin.readlines.join)
        end
      end

      define_task("user:key:rm", "remove a user's key") do |login, key_name|
        use_if_not_nil Gritano::Core::User.where(login: login).first do |user|
          destroy_model(user.keys, name: key_name)
        end
      end

      define_task("repo:list", "list all repositories") do
        render_table(Gritano::Core::Repository.order(:name), :name)
      end

      define_task("repo:add", "add a new repository") do |name|
        create_model(Gritano::Core::Repository, name: name, path: "tmp")
      end

      define_task("repo:rm", "remove a repository") do |name|
        destroy_model(Gritano::Core::Repository, name: name)
      end

      define_task("repo:read:add", "add read access to a repository") do |repo_name, user_login|
        use_if_not_nil Gritano::Core::User.where(login: user_login).first, Gritano::Core::Repository.where(name: repo_name).first do |user, repo|
          if user.add_access(repo, :read)
            puts "done"
          else
            puts "an error occurred"
          end
        end
      end

      define_task("repo:read:rm", "remove read access to a repository") do |repo_name, user_login|
        use_if_not_nil Gritano::Core::User.where(login: user_login).first, Gritano::Core::Repository.where(name: repo_name).first do |user, repo|
          if user.remove_access(repo, :read)
            puts "done"
          else
            puts "an error occurred"
          end
        end
      end

      define_task("repo:write:add", "add write access to a repository") do |repo_name, user_login|
        use_if_not_nil Gritano::Core::User.where(login: user_login).first, Gritano::Core::Repository.where(name: repo_name).first do |user, repo|
          if user.add_access(repo, :write)
            puts "done"
          else
            puts "an error occurred"
          end
        end
      end

      define_task("repo:write:rm", "remove write access to a repository") do |repo_name, user_login|
        use_if_not_nil Gritano::Core::User.where(login: user_login).first, Gritano::Core::Repository.where(name: repo_name).first do |user, repo|
          if user.remove_access(repo, :write)
            puts "done"
          else
            puts "an error occurred"
          end
        end
      end

      define_task("repo:user:list", "list all user that have access to a repository") do |repo_name|
        use_if_not_nil Gritano::Core::Repository.where(name: repo_name).first do |repo|
          render_table(repo.users.order(:login), :login, :access => repo)
        end
      end

      private

      def self.render_table(elements, *attributes)
        attributes_hash = {}
        attributes.each do |a|
          if a.respond_to?(:keys)
            attributes_hash = attributes_hash.merge(a)
          else
            attributes_hash[a] = nil
          end
        end
        table = Terminal::Table.new do |t|
          t << attributes_hash.map { |key, value| key }
          t << :separator
          elements.each do |element|
            row = []
            attributes_hash.each do |attribute, params|
              if params
                row << element.send(attribute, params)
              else
                row << element.send(attribute)
              end
            end
            t.add_row row
          end
        end
        puts table
      end

      def self.create_model(model, params)
        instance = model.new(params)
        if instance.save
          puts "#{model.name.split(':')[-1].downcase} was successfully created."
        else
          puts "an error occurred."
        end
      end

      def self.destroy_model(model, params)
        instance = model.where(params).first
        if instance
          instance.destroy
          puts "#{model.name.split(':')[-1].downcase} was successfully destroyed."
        else
          puts "#{model.name.split(':')[-1].downcase} doens't exist."
        end
      end

      def self.use_if_not_nil(*variables, &block)
        unless variables.index(nil)
          block.call(*variables)
        else
          puts "an error occurred"
        end
      end

    end
  end
end