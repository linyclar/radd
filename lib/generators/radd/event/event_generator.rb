# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/params_option_concern"

module Radd
  module Generators
    # Eventクラスのジェネレータ
    class EventGenerator < Rails::Generators::NamedBase
      include Radd::FeatureConcern
      include Radd::ParamsOptionConcern

      source_root File.expand_path("templates", __dir__)

      def copy_event
        template "event.erb", generate_file(event)
      end
      hook_for :test_framework, as: "radd:event"

      private

      def event
        @event ||= to_event(file_name)
      end

      def cam_event
        @cam_event ||= event.camelize
      end

      def to_event(name)
        to_with_name(name, "event")
      end
    end
  end
end
