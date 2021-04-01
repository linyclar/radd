# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/params_option_concern"

module Radd
  module Generators
    # ValueObjectクラスのジェネレータ
    class ValueObjectGenerator < Rails::Generators::NamedBase
      include Radd::FeatureConcern
      include Radd::ParamsOptionConcern

      source_root File.expand_path("templates", __dir__)

      def copy_value_object
        template "value_object.erb", generate_file(value_object)
      end
      hook_for :test_framework, as: "radd:value_object"

      private

      def value_object
        @value_object ||= to_with_name(file_name, "value_object")
      end

      def cam_value_object
        @cam_value_object ||= value_object.camelize
      end
    end
  end
end
