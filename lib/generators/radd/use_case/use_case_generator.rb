# frozen_string_literal: true

require "generators/radd/use_case_concern"

module Radd
  module Generators
    # UseCaseクラスのジェネレータ
    class UseCaseGenerator < Rails::Generators::NamedBase
      include Radd::UseCaseConcern

      source_root File.expand_path("templates", __dir__)

      def copy_use_case
        template "use_case.erb", generate_file
      end
      hook_for :test_framework, as: "radd:use_case"

      private

      def generate_file
        return @generate_file if @generate_file.present?

        path = subjects + [actor, use_case].reject(&:blank?)
        @generate_file = "app/use_cases/#{path.join("/")}.rb"
      end

      def use_case
        @use_case ||= to_with_name(file_name, "use_case")
      end

      def cam_use_case
        @cam_use_case ||= use_case.camelize
      end

      def actor
        @actor ||= to_with_name(regular_class_path.last, "actor")
      end

      def module_actor(&block)
        body = capture(&block)
        body = body.each_line.map { |line| line.sub(/^  /, "") }.join
        return concat(body) if actor.blank?

        concat("module #{cam_actor}\n#{indent(body)}end\n")
      end

      def def_initialize
        if actor.present?
          return <<~DEF
            attr_accessor :actor

            def initialize(actor)
              self.actor = actor
            end
          DEF
        end

        <<~DEF
          def initialize
          end
        DEF
      end
    end
  end
end
