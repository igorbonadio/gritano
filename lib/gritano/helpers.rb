module Gritano
  module CLI
    module Helpers
      def create_model(model, params)
        instance = model.new(params)
        if instance.save
          render_text "#{model.name.split(':')[-1].downcase} was successfully created."
        else
          render_text "an error occurred.", :error
        end
      end

      def update_model(instance, params)
        if instance.update_attributes(params)
          render_text "#{instance.class.name.split(':')[-1].downcase} was successfully updated."
        else
          render_text "an error occurred.", :error
        end
      end

      def destroy_model(model, params)
        instance = model.where(params).first
        if instance
          instance.destroy
          render_text "#{model.name.split(':')[-1].downcase} was successfully destroyed."
        else
          render_text "#{model.name.split(':')[-1].downcase} doens't exist.", :error
        end
      end

      def use_if_not_nil(*variables, &block)
        unless variables.index(nil)
          block.call(*variables)
        else
          render_text "an error occurred", :error
        end
      end

      def try_change_access(user, repo, add_or_rm, read_or_write)
        if user.send("#{add_or_rm}_access", repo, read_or_write)
          render_text "done"
        else
          render_text "an error occurred", :error
        end
      end

      def valid_options?(options)
        true unless options.empty?
      end
    end
  end
end