# frozen_string_literal: true

require "generators/radd/use_case_concern"

module Radd
  module Generators
    # SwimLaneクラスのジェネレータ
    class SwimLaneGenerator < Rails::Generators::NamedBase
      include Radd::UseCaseConcern

      source_root File.expand_path("templates", __dir__)

      def copy_swim_lane
        template "swim_lane.erb", generate_file
      end
      hook_for :test_framework, as: "radd:swim_lane"

      private

      def generate_file
        return @generate_file if @generate_file.present?

        path = subjects + [swim_lane, actor].reject(&:blank?)
        raise "スイムレーンとアクターを指定してください" if swim_lane.blank?

        @generate_file = "app/use_cases/#{path.join("/")}.rb"
      end

      def actor
        @actor ||= to_with_name(file_name, "actor")
      end

      def swim_lane
        @swim_lane ||= to_swim_lane(regular_class_path.last)
      end

      def cam_swim_lane
        @cam_swim_lane ||= swim_lane.camelize
      end

      def to_swim_lane(name)
        to_with_name(name, "swim_lane")
      end
    end
  end
end
