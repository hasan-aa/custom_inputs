module Formtastic
  module Inputs
    class ListInput
      include Base
      include InputHelpers

      def has_quantity?
        if @has_quantity.nil?
          @has_quantity = options[:has_quantity]
          @has_quantity = true if @has_quantity.nil?
        end
        @has_quantity
      end

      def to_html
        fields = options[:fields] # [{'Header Text': :key}... ]
        values = @object ? @object.send(method) : nil

        input_wrapping do
          label_html <<
              template.content_tag(:div, class: 'item-quantity-group') do
                tags = select_html
                tags << quantity_html if has_quantity?
                tags << buttons(false)
              end <<
              template.content_tag(:div, nil, class: 'item-list-container') do
                # Table
                template.content_tag(:table, class: 'item-table') do
                  # Headers
                  template.content_tag(:tr) do
                    headers = fields.map {|field|
                      header = field.first[0]
                      template.content_tag(:th, header.to_s)
                    }.join.html_safe
                    # Quantity header
                    headers << template.content_tag(:th, 'Quantity') if has_quantity?
                    # Button header
                    headers << template.content_tag(:th)
                  end <<
                      table_row << #hidden template row for js use.
                      if values
                        values.map {|value| table_row(false, value)}.join.html_safe
                      end
                end
              end
        end
      end

      private

      def table_row(hidden = true, item = nil)
        # Generating sample hidden row
        unique_field = options[:unique_field] || 'id'
        unique_value = item
        quantity = nil
        if item and has_quantity?
          unique_value = item[unique_field.to_s]
          quantity = item['quantity']
        end

        item_data = options[:collection_object].find_by("#{unique_field}": unique_value)
        item_data ||= {}
        fields = options[:fields]

        css_classes = 'item-row'
        css_classes += ' hidden' if hidden
        template.content_tag(:tr, class: css_classes, id: "row_#{item_data[:id]}") do
          cells = fields.map {|field|
            key = field.first[1]
            cell = template.content_tag(:td, "", class: "#{key}-cell", field: key.to_s) do
              item_data[key].to_s
            end
            cell << hidden_field(key, true, item_data[key]) if has_quantity?
            cell
          }.join.html_safe

          if has_quantity?
            # Quantity cell
            cells << template.content_tag(:td, class: 'quantity-cell') do
              quantity
            end
            cells << hidden_field('quantity', false, quantity)
          else
            cells << hidden_field(unique_field, false, unique_value)
          end

          # Button cell
          cells << template.content_tag(:td, width: '26px') do
            buttons(true)
          end
        end
      end

      def select_html
        template.select_tag('', template.options_from_collection_for_select(options[:collection_object], 'to_json', options[:to_s_method] || 'to_s'), input_html_options.merge({class: 'item-item', name: ''}))
      end

      def quantity_html
        builder.number_field('', input_html_options.merge({class: 'item-quantity', value: 1, name: ''}))
      end

      def hidden_field(key, insert_field_attr = true, value = nil)
        options = {class: "hidden-#{key}"}
        options['field'] = key.to_s if insert_field_attr

        if has_quantity?
          # When with quantity build an array of objects with fields given in options.
          # template.hidden_field_tag("#{object_name}[#{method}][][#{key}]", value = value, options = options)
          ci_hidden_field("#{object_name}[#{method}][][#{key}]", value = value, options = options)
        else
          # When without quantity build an array of IDs
          ci_hidden_field("#{object_name}[#{method}][]", value = value, options = options)
        end
      end

      def buttons(remove = true)
        if remove
          button = template.content_tag(:button, icon_tag('minus-circle'), class: 'array-action--remove js-remove-from-items-input', type: 'button')
        else
          button = template.content_tag(:button, icon_tag('plus-circle'), class: 'array-action--add js-add-to-items-input', type: 'button')
        end
        button
      end
    end
  end
end