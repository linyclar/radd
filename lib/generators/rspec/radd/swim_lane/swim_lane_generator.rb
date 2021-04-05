# frozen_string_literal: true

require "generators/radd/use_case_generator_concern"
require "generators/radd/swim_lane_concern"

module Rspec
  module Radd
    module Generators
      # SwimLaneクラスのRSpecジェネレータ
      class SwimLaneGenerator < Rails::Generators::NamedBase
        include ::Radd::UseCaseGeneratorConcern
        include ::Radd::SwimLaneConcern

        source_root File.expand_path("templates", __dir__)

        def copy_swim_lane
          template "swim_lane_spec.erb", generate_file
        end

        private

        def target_class
          clazzes = cam_subjects + [cam_swim_lane, cam_actor]
          clazzes.reject(&:blank?).join("::")
        end

        def spec?
          true
        end
      end
    end
  end
end
