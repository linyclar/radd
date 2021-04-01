# frozen_string_literal: true

require "spec_helper"
require "generators/radd/rule/rule_generator"

RSpec.describe Radd::CommonConcern do
  subject(:generator) { Radd::Generators::RuleGenerator.new(["calc"]) }

  # テストが難しいため
  # spec/generators/radd/rule_generator_spec.rbの
  # copy_ruleメソッドのテストで間接的にテストしたことにする
  # describe '#modules'

  describe "#to_with_name" do
    %w[calc calc_rule].each do |rule_name|
      context "#{rule_name}が指定された場合" do
        it "calc_ruleが返る" do
          expect(generator.send(:to_with_name, rule_name, "rule")).to eq "calc_rule"
        end
      end
    end
  end
end
