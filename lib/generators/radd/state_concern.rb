# frozen_string_literal: true

require "generators/radd/common_concern"

module Radd
  # State、ViewState用のヘルパーメソッド
  module StateConcern
    include Radd::CommonConcern

    private

    def state
      @state ||= to_with_name(file_name, file_suffix)
    end

    def cam_state
      @cam_state ||= state.camelize
    end
  end
end
