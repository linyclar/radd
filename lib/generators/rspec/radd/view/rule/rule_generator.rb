# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/rule_concern"

module Rspec
  module Radd
    module View
      module Generators
        # ViewRuleクラスのRSpecジェネレータ
        class RuleGenerator < Rails::Generators::NamedBase
          include ::Radd::FeatureConcern
          include ::Radd::RuleConcern

          source_root File.expand_path("templates", __dir__)

          def copy_rule
            template "rule_spec.erb", generate_file(rule)
          end

          private

          def file_suffix
            "view_rule"
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
