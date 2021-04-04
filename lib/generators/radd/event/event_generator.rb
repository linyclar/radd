# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/params_option_concern"
require "generators/radd/event_concern"

module Radd
  module Generators
    # Eventクラスのジェネレータ
    class EventGenerator < Rails::Generators::NamedBase
      include Radd::FeatureConcern
      include Radd::ParamsOptionConcern
      include Radd::EventConcern

      source_root File.expand_path("templates", __dir__)

      def copy_event
        template "event.erb", generate_file(event)
      end
      hook_for :test_framework, as: "radd:event"
    end
  end
end
