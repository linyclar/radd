# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/delegate_option_concern"
require "generators/radd/view_model_concern"

module Radd
  module View
    module Generators
      # ViewModelクラスのジェネレータ
      class ModelGenerator < Rails::Generators::NamedBase
        include Radd::FeatureConcern
        include Radd::DelegateOptionConcern
        include Radd::ViewModelConcern

        source_root File.expand_path("templates", __dir__)

        def copy_model
          template "model.erb", generate_file(model)
        end
        hook_for :test_framework, as: "radd:view:model"

        private

        def dir_path
          "view_models"
        end
      end
    end
  end
end
