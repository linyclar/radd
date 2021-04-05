# frozen_string_literal: true

require "generators/radd/common_concern"

module Radd
  # UseCase、UseCaseのRSpecファイル用のヘルパーメソッド
  module UseCaseConcern
    include Radd::CommonConcern

    private

    def use_case
      @use_case ||= to_with_name(file_name, "use_case")
    end

    def cam_use_case
      @cam_use_case ||= use_case.camelize
    end

    def actor
      @actor ||= to_with_name(regular_class_path.last, "actor")
    end

    def generate_file
      return @generate_file if @generate_file.present?

      path = subjects + [actor, use_case].reject(&:blank?)
      @generate_file = "#{root_path}/use_cases/#{path.join("/")}#{generate_file_suffix}.rb"
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
