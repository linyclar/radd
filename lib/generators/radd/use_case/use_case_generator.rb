# frozen_string_literal: true

require "generators/radd/use_case_generator_concern"
require "generators/radd/use_case_concern"

module Radd
  module Generators
    # UseCaseクラスのジェネレータ
    class UseCaseGenerator < Rails::Generators::NamedBase
      include Radd::UseCaseGeneratorConcern
      include Radd::UseCaseConcern

      source_root File.expand_path("templates", __dir__)

      def copy_use_case
        template "use_case.erb", generate_file
      end
      hook_for :test_framework, as: "radd:use_case"

      private

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
