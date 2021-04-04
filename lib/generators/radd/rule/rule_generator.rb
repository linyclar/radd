# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/params_option_concern"
require "generators/radd/rule_concern"

module Radd
  module Generators
    # Ruleクラスのジェネレータ
    class RuleGenerator < Rails::Generators::NamedBase
      include Radd::FeatureConcern
      include Radd::ParamsOptionConcern
      include Radd::RuleConcern

      source_root File.expand_path("templates", __dir__)

      def copy_rule
        template "rule.erb", generate_file(rule)
      end
      hook_for :test_framework, as: "radd:rule"

      private

      def file_suffix
        "rule"
      end
    end
  end
end
