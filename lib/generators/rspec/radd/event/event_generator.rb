# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/params_option_concern"
require "generators/radd/event_concern"

module Rspec
  module Radd
    module Generators
      # EventクラスのRSpecジェネレータ
      class EventGenerator < Rails::Generators::NamedBase
        include ::Radd::FeatureConcern
        include ::Radd::ParamsOptionConcern
        include ::Radd::EventConcern

        source_root File.expand_path("templates", __dir__)

        def copy_event
          template "event_spec.erb", generate_file(event)
        end

        private

        def spec?
          true
        end
      end
    end
  end
end
