# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/params_option_concern"
require "generators/radd/state_concern"

module Rspec
  module Radd
    module Generators
      # StateクラスのRSpecジェネレータ
      class StateGenerator < Rails::Generators::NamedBase
        include ::Radd::FeatureConcern
        include ::Radd::ParamsOptionConcern
        include ::Radd::StateConcern

        source_root File.expand_path("templates", __dir__)

        def copy_state
          template "state_spec.erb", generate_file(state)
        end

        private

        def file_suffix
          "state"
        end

        def spec?
          true
        end
      end
    end
  end
end
