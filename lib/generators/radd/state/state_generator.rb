# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/params_option_concern"

module Radd
  module Generators
    # Stateクラスのジェネレータ
    class StateGenerator < Rails::Generators::NamedBase
      include Radd::FeatureConcern
      include Radd::ParamsOptionConcern

      source_root File.expand_path("templates", __dir__)

      def copy_state
        template "state.erb", generate_file(state)
      end
      hook_for :test_framework, as: "radd:state"

      private

      def state
        @state ||= to_with_name(file_name, "state")
      end

      def cam_state
        @cam_state ||= state.camelize
      end
    end
  end
end
