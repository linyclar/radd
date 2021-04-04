# frozen_string_literal: true

require "generators/radd/common_concern"
module Radd
  # Featureモジュールの出力関係ヘルパーメソッド
  module FeatureConcern
    include Radd::CommonConcern

    private

    def features
      return @features if @features.present?

      @features = regular_class_path.map do |module_name|
        to_with_name(module_name, "feature")
      end
    end

    def cam_features
      @cam_features ||= features.map(&:camelize)
    end

    def module_features(&block)
      modules(cam_features, &block)
    end

    def generate_file(file)
      return @generate_file if @generate_file.present?

      path = features + [file]
      @generate_file = "#{root_path}/#{dir_path}/#{path.join("/")}#{generate_file_suffix}.rb"
    end

    def dir_path
      "domains"
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
