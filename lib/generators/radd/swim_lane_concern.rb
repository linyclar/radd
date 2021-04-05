# frozen_string_literal: true

require "generators/radd/common_concern"

module Radd
  # SwimLane、SwimLaneのRSpecファイル用のヘルパーメソッド
  module SwimLaneConcern
    include Radd::CommonConcern

    private

    def generate_file
      return @generate_file if @generate_file.present?

      raise "スイムレーンとアクターを指定してください" if swim_lane.blank?

      path = subjects + [swim_lane, actor].reject(&:blank?)
      @generate_file = "#{root_path}/use_cases/#{path.join("/")}#{generate_file_suffix}.rb"
    end

    def actor
      @actor ||= to_with_name(file_name, "actor")
    end

    def swim_lane
      @swim_lane ||= to_with_name(regular_class_path.last, "swim_lane")
    end

    def cam_swim_lane
      @cam_swim_lane ||= swim_lane.camelize
    end

    def root_path
      spec? ? "spec" : "app"
    end

    def generate_file_suffix
      spec? ? "_spec" : ""
    end

    def spec?
      false
    end
  end
end
