# frozen_string_literal: true

module Radd
  # 全体共通で利用するヘルパーメソッド
  module CommonConcern
    private

    def modules(module_names, &block)
      body = capture(&block)
      body = body.each_line.map { |line| line.sub(/^  /, "") }.join

      module_names.reverse_each do |module_name|
        body = "module #{module_name}\n#{indent(body)}end\n"
      end
      body = body.sub(/\n\z/, "")
      concat(body)
    end

    def to_with_name(name, with)
      return "" if name.blank?
      return name if /_#{with}\z/.match?(name)

      "#{name}_#{with}"
    end
  end
end
