# frozen_string_literal: true

require "generators/radd/common_concern"
module Radd
  # UseCase、SwimLaneのジェネレータで利用するヘルパーメソッド
  module UseCaseGeneratorConcern
    include Radd::CommonConcern

    private

    def subjects
      return @subjects if @subjects.present?

      @subjects = regular_class_path[0..-2].map do |module_name|
        to_with_name(module_name, "subject")
      end
    end

    def cam_subjects
      @cam_subjects ||= subjects.map(&:camelize)
    end

    def module_subjects(&block)
      modules(cam_subjects, &block)
    end

    def cam_actor
      @cam_actor ||= actor.camelize
    end
  end
end
