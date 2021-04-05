# frozen_string_literal: true

require "generators/radd/use_case_generator_concern"
require "generators/radd/use_case_concern"

module Rspec
  module Radd
    module Generators
      # UseCaseクラスのRSpecジェネレータ
      class UseCaseGenerator < Rails::Generators::NamedBase
        include ::Radd::UseCaseGeneratorConcern
        include ::Radd::UseCaseConcern

        source_root File.expand_path("templates", __dir__)

        def copy_use_case
          template "use_case_spec.erb", generate_file
        end

        private

        def target_class
          clazzes = cam_subjects + [cam_actor, cam_use_case]
          clazzes.reject(&:blank?).join("::")
        end

        def spec?
          true
        end
      end
    end
  end
end
