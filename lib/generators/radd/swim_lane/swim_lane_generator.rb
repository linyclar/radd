# frozen_string_literal: true

require "generators/radd/use_case_generator_concern"
require "generators/radd/swim_lane_concern"

module Radd
  module Generators
    # SwimLaneクラスのジェネレータ
    class SwimLaneGenerator < Rails::Generators::NamedBase
      include Radd::UseCaseGeneratorConcern
      include Radd::SwimLaneConcern

      source_root File.expand_path("templates", __dir__)

      def copy_swim_lane
        template "swim_lane.erb", generate_file
      end
      hook_for :test_framework, as: "radd:swim_lane"
    end
  end
end
