# frozen_string_literal: true

require "generators/radd/common_concern"

module Radd
  # Rule、ViewRule用のヘルパーメソッド
  module RuleConcern
    include Radd::CommonConcern

    private

    def rule
      @rule ||= to_with_name(file_name, file_suffix)
    end

    def cam_rule
      @cam_rule ||= rule.camelize
    end
  end
end
