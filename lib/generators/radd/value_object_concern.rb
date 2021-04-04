# frozen_string_literal: true

require "generators/radd/common_concern"

module Radd
  # ValueObject、ViewValueObject用のヘルパーメソッド
  module ValueObjectConcern
    include Radd::CommonConcern

    private

    def value_object
      @value_object ||= to_with_name(file_name, file_suffix)
    end

    def cam_value_object
      @cam_value_object ||= value_object.camelize
    end
  end
end
