# frozen_string_literal: true

require "generators/radd/common_concern"

module Radd
  # Entity、EntityのRSpecファイル用のヘルパーメソッド
  module EntityConcern
    include Radd::CommonConcern

    private

    def entity
      @entity ||= file_name
    end

    def cam_entity
      @cam_entity ||= entity.camelize
    end
  end
end
