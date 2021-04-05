# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/value_object_concern"

module Rspec
  module Radd
    module View
      module Generators
        # ViewValueObjectクラスのRSpecジェネレータ
        class ValueObjectGenerator < Rails::Generators::NamedBase
          include ::Radd::FeatureConcern
          include ::Radd::ValueObjectConcern

          source_root File.expand_path("templates", __dir__)

          def copy_value_object
            template "value_object_spec.erb", generate_file(value_object)
          end

          private

          def file_suffix
            "view_value_object"
          end

          def dir_path
            "view_models"
          end

          def spec?
            true
          end
        end
      end
    end
  end
end
