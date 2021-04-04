# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/params_option_concern"
require "generators/radd/state_concern"

module Radd
  module Generators
    # Stateクラスのジェネレータ
    class StateGenerator < Rails::Generators::NamedBase
      include Radd::FeatureConcern
      include Radd::ParamsOptionConcern
      include Radd::StateConcern

      source_root File.expand_path("templates", __dir__)

      def copy_state
        template "state.erb", generate_file(state)
      end
      hook_for :test_framework, as: "radd:state"

      private

      def file_suffix
        "state"
      end
    end
  end
end
