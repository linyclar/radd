# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/params_option_concern"
require "generators/radd/value_object_concern"

module Rspec
  module Radd
    module Generators
      # ValueObjectクラスのRSpecジェネレータ
      class ValueObjectGenerator < Rails::Generators::NamedBase
        include ::Radd::FeatureConcern
        include ::Radd::ParamsOptionConcern
        include ::Radd::ValueObjectConcern

        source_root File.expand_path("templates", __dir__)

        def copy_value_object
          template "value_object_spec.erb", generate_file(value_object)
        end

        private

        def file_suffix
          "value_object"
        end

        def spec?
          true
        end
      end
    end
  end
end
