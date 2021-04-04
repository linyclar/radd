# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/params_option_concern"
require "generators/radd/state_concern"

module Radd
  module View
    module Generators
      # ViewStateクラスのジェネレータ
      class StateGenerator < Rails::Generators::NamedBase
        include Radd::FeatureConcern
        include Radd::ParamsOptionConcern
        include Radd::StateConcern

        source_root File.expand_path("templates", __dir__)

        def copy_state
          path = features + [state]
          template "state.erb", "app/view_models/#{path.join("/")}.rb"
        end
        hook_for :test_framework, as: "radd:view:state"

        private

        def file_suffix
          "view_state"
        end

        def dir_path
          "view_models"
        end
      end
    end
  end
end
