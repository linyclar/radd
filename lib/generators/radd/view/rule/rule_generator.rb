# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/params_option_concern"
require "generators/radd/rule_concern"

module Radd
  module View
    module Generators
      # ViewRuleクラスのジェネレータ
      class RuleGenerator < Rails::Generators::NamedBase
        include Radd::FeatureConcern
        include Radd::ParamsOptionConcern
        include Radd::RuleConcern

        source_root File.expand_path("templates", __dir__)

        def copy_rule
          path = features + [rule]
          template "rule.erb", "app/view_models/#{path.join("/")}.rb"
        end
        hook_for :test_framework, as: "radd:view:rule"

        private

        def file_suffix
          "view_rule"
        end

        def dir_path
          "view_models"
        end
      end
    end
  end
end
