require "formtastic"

module CustomInputs
  class Engine < ::Rails::Engine
    config.autoload_paths += Dir["#{config.root}/lib"]
    # ActiveSupport::Dependencies.explicitly_unloadable_constants << 'Formtastic::Inputs::ArrayInput'
  end
end

