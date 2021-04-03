# frozen_string_literal: true

module Radd
  # delegate定義を出力するヘルパーメソッド
  module DelegateOptionConcern
    def self.included(klass)
      klass.class_option :delegate, aliases: :d
    end

    private

    def delegate_to
      return if delegate_options.blank?

      "delegate #{delegate_options.join(", ")}, to: :raw\n"
    end

    def delegate_options
      return @delegate_options if @delegate_options

      @delegate_options = []
      return @delegate_options if options[:delegate].blank?

      @delegate_options = options[:delegate].split(",").map { |d| ":#{d}" }
    end
  end
end
