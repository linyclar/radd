# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/state_concern"

module Rspec
  module Radd
    module View
      module Generators
        # ViewStateクラスのRSpecジェネレータ
        class StateGenerator < Rails::Generators::NamedBase
          include ::Radd::FeatureConcern
          include ::Radd::StateConcern

          source_root File.expand_path("templates", __dir__)

          def copy_state
            template "state_spec.erb", generate_file(state)
          end

          private

          def file_suffix
            "view_state"
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
