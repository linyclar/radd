# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/params_option_concern"
require "generators/radd/entity_concern"

module Rspec
  module Radd
    module Generators
      # EntityクラスのRSpecジェネレータ
      class EntityGenerator < Rails::Generators::NamedBase
        include ::Radd::FeatureConcern
        include ::Radd::ParamsOptionConcern
        include ::Radd::EntityConcern

        source_root File.expand_path("templates", __dir__)

        def copy_entity
          template "entity_spec.erb", generate_file(entity)
        end

        private

        def spec?
          true
        end
      end
    end
  end
end
