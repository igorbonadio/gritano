module Gritano
  module CLI
    module Helpers
      def create_model(model, params)
        instance = model.new(params)
        if instance.save
          render_text "#{model.name.split(':')[-1].downcase} was successfully created."
        else
          render_text "an error occurred."
        end
      end

      def destroy_model(model, params)
        instance = model.where(params).first
        if instance
          instance.destroy
          render_text "#{model.name.split(':')[-1].downcase} was successfully destroyed."
        else
          render_text "#{model.name.split(':')[-1].downcase} doens't exist."
        end
      end

      def use_if_not_nil(*variables, &block)
        unless variables.index(nil)
          block.call(*variables)
        else
          render_text "an error occurred"
        end
      end
    end
  end
end