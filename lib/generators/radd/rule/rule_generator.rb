# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/params_option_concern"

module Radd
  module Generators
    # Ruleクラスのジェネレータ
    class RuleGenerator < Rails::Generators::NamedBase
      include Radd::FeatureConcern
      include Radd::ParamsOptionConcern

      source_root File.expand_path("templates", __dir__)

      def copy_rule
        template "rule.erb", generate_file
      end
      hook_for :test_framework, as: "radd:rule"

      private

      def generate_file
        return @generate_file if @generate_file.present?

        path = features + [rule]
        @generate_file = "app/domains/#{path.join("/")}.rb"
      end

      def rule
        @rule ||= to_with_name(file_name, "rule")
      end

      def cam_rule
        @cam_rule ||= rule.camelize
      end
    end
  end
end
