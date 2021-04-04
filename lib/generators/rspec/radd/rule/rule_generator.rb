# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/params_option_concern"
require "generators/radd/rule_concern"

module Rspec
  module Radd
    module Generators
      # RuleクラスのRSpecジェネレータ
      class RuleGenerator < Rails::Generators::NamedBase
        include ::Radd::FeatureConcern
        include ::Radd::ParamsOptionConcern
        include ::Radd::RuleConcern

        source_root File.expand_path("templates", __dir__)

        def copy_rule
          template "rule_spec.erb", generate_file(rule)
        end

        private

        def file_suffix
          "rule"
        end

        def spec?
          true
        end
      end
    end
  end
end
