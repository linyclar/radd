# frozen_string_literal: true

module Radd
  # コンストラクタに引数を指定する場合に利用するヘルパーメソッド
  module ParamsOptionConcern
    def self.included(klass)
      klass.argument :params_option, required: false
    end

    private

    def attr_accessor_params
      return if params.blank?

      fields = params.map { |p| ":#{p}" }.join(", ")
      "attr_accessor #{fields}"
    end

    def def_initialize
      if params.blank?
        return <<~DEF
          def initialize
          end
        DEF
      end

      body = params.map do |param|
        "self.#{param} = #{param}\n"
      end
      <<~DEF
        def initialize(#{params.join(", ")})
        #{indent(body.join.chomp)}
        end
      DEF
    end

    def params
      return [] if params_option.blank?

      params_option.split(",")
    end
  end
end
