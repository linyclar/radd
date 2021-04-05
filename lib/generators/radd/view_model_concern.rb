# frozen_string_literal: true

require "generators/radd/common_concern"

module Radd
  # ViewModel、ViewModelのRSpecファイル用のヘルパーメソッド
  module ViewModelConcern
    include Radd::CommonConcern

    private

    def model
      @model ||= to_with_name(file_name, "view_model")
    end

    def cam_model
      @cam_model ||= model.camelize
    end
  end
end
