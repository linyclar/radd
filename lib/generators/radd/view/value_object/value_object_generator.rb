# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/params_option_concern"
require "generators/radd/value_object_concern"

module Radd
  module View
    module Generators
      # ViewValueObjectクラスのジェネレータ
      class ValueObjectGenerator < Rails::Generators::NamedBase
        include Radd::FeatureConcern
        include Radd::ParamsOptionConcern
        include Radd::ValueObjectConcern

        source_root File.expand_path("templates", __dir__)

        def copy_value_object
          template "value_object.erb", generate_file(value_object)
        end
        hook_for :test_framework, as: "radd:view:value_object"

        private

        def file_suffix
          "view_value_object"
        end

        def dir_path
          "view_models"
        end
      end
    end
  end
end
