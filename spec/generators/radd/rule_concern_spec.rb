# frozen_string_literal: true

require "spec_helper"
require "generators/radd/rule/rule_generator"

RSpec.describe Radd::RuleConcern do
  subject(:generator) { Radd::Generators::RuleGenerator.new([rule]) }

  let(:rule) { "calc" }

  describe "#rule" do
    %w[calc calc_rule Calc CalcRule accounting_feature/calc_rule AccountingFeature::CalcRule].each do |rule_name|
      context "#{rule_name}が指定された場合" do
        let(:rule) { rule_name }

        it "calc_ruleが返る" do
          expect(generator.send(:rule)).to eq "calc_rule"
        end
      end
    end
  end

  describe "#cam_rule" do
    %w[calc calc_rule Calc CalcRule accounting_feature/calc_rule AccountingFeature::CalcRule].each do |rule_name|
      context "#{rule_name}が指定された場合" do
        let(:rule) { rule_name }

        it "CalcRuleが返る" do
          expect(generator.send(:cam_rule)).to eq "CalcRule"
        end
      end
    end
  end
end
