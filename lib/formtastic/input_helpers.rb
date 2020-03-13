module Formtastic
  module InputHelpers
    def icon_tag(icon_name)
      template.content_tag(:i, '', class: "fa fa-#{icon_name}")
    end

    def input_classes(options)
      classes = 'custom-inputs--input-field'
      classes += ' ' + options[:class] if options[:class]
      classes
    end

    def ci_hidden_field(name, value = nil, options = {})
      template.hidden_field_tag(name, value, options.merge(class: input_classes(options)))
    end

    def ci_text_field(name, value = nil, options = {})
      template.text_field_tag(name, value, options.merge(class: input_classes(options)))
    end

  end
end
