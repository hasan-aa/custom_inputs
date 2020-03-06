module Formtastic
  module Inputs

    class ArrayInput
      include Base

      def to_html
        @undoable = options[:undoable]
        input_wrapping do
          inputs = []

          values = @object.send(method)
          if values
            values.each_with_index do |v, x|
              inputs << array_input_html(v)
            end
          end

          label_html <<
              template.content_tag(:div, class: 'input-group--array') do
                inputs.join.html_safe <<
                    array_input_html('', false) <<
                    array_input_html('', true, true) # template for creating new array input field
              end
        end
      end

      private

      def array_input_html(value, remove = true, hidden = false)
        icon_classes = remove ? 'fa fa-minus-circle' : 'fa fa-plus-circle'
        button_classes = remove ? 'array-action--remove js-remove-from-array-input' : 'array-action--add js-add-to-array-input'
        button_classes += ' undoable' if @undoable

        button = template.content_tag(:button,
                                      template.content_tag(:i, '', class: icon_classes),
                                      class: button_classes,
                                      type: 'button')

        wrapper_classes = 'input-group--array__item'
        wrapper_classes += ' hidden template' if hidden

        template.content_tag(:div, class: wrapper_classes) do
          template.text_field_tag("#{object_name}[#{method}][]", value, id: nil, disabled: hidden) << button
        end
      end

    end
  end
end
