# frozen_string_literal: true

require "generators/radd/common_concern"

module Radd
  # Event、EventのRSpecファイル用のヘルパーメソッド
  module EventConcern
    include Radd::CommonConcern

    private

    def event
      @event ||= to_with_name(file_name, "event")
    end

    def cam_event
      @cam_event ||= event.camelize
    end
  end
end
