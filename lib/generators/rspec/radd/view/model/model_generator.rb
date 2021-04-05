# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/view_model_concern"

module Rspec
  module Radd
    module View
      module Generators
        # ViewModelクラスのRSpecジェネレータ
        class ModelGenerator < Rails::Generators::NamedBase
          include ::Radd::FeatureConcern
          include ::Radd::ViewModelConcern

          source_root File.expand_path("templates", __dir__)

          def copy_model
            template "model_spec.erb", generate_file(model)
          end

          private

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
