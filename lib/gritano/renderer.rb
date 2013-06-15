module Gritano
  module CLI
    module Renderer
      def render_text(text, level = :success)
        if level == :success
          puts text.color(:green)
        else
          puts text.color(:red)
        end
      end

      def render_table(elements, *attributes)
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
        render_text table.to_s
      end
    end
  end
end