# frozen_string_literal: true

require "generators/radd/feature_concern"
require "generators/radd/delegate_option_concern"

module Radd
  module Generators
    # Entityクラスのジェネレータ
    class EntityGenerator < Rails::Generators::NamedBase
      include Radd::FeatureConcern
      include Radd::DelegateOptionConcern

      source_root File.expand_path("templates", __dir__)

      class_option :model, aliases: :m

      def copy_entity
        template "entity.erb", generate_file(entity)
      end
      hook_for :test_framework, as: "radd:entity"

      def inject_model
        return if model_file_path.blank?

        mapper = <<~MAPPER
          def to_#{features_string}
            #{cam_features.join("::")}::#{cam_entity}.new(self)
          end
        MAPPER

        insert_into_file model_file_path, indent(mapper), before: /^end$/
      end

      private

      def model_file_path
        return @model_file_path if @model_file_path

        @model_file_path = ""
        return @model_file_path if options[:model].blank?

        model_file = options[:model].underscore.singularize
        @model_file_path = "app/models/#{model_file}.rb"
      end

      def features_string
        return @features_string if @features_string.present?

        features_array = features.dup
        last = features_array.pop
        features_array.map! { |f| f.sub(/_feature\z/, "") }
        @features_string = (features_array + [last]).join("_")
        @features_string = @features_string.presence || "entity"
      end

      def entity
        @entity ||= file_name
      end

      def cam_entity
        @cam_entity ||= entity.camelize
      end
    end
  end
end
