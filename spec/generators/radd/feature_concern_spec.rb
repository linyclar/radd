# frozen_string_literal: true

require "spec_helper"
require "generators/radd/rule/rule_generator"

RSpec.describe Radd::FeatureConcern do
  subject(:generator) { Radd::Generators::RuleGenerator.new([rule_name]) }

  describe "#features" do
    %w[accounting/calc accounting_feature/calc Accounting::Calc AccountingFeature::Calc].each do |rule|
      context rule do
        let(:rule_name) { rule }

        it "accounting_featureが返る" do
          expect(generator.send(:features)).to eq ["accounting_feature"]
        end
      end
    end
    context "accounting/common/calc" do
      let(:rule_name) { "accounting/common/calc" }

      it "accounting_featureとcommon_featureが配列で返る" do
        expect(generator.send(:features)).to eq %w[accounting_feature common_feature]
      end
    end
  end

  describe "#cam_features" do
    %w[accounting/calc accounting_feature/calc Accounting::Calc AccountingFeature::Calc].each do |rule|
      context rule do
        let(:rule_name) { rule }

        it "AccountingFeatureが返る" do
          expect(generator.send(:cam_features)).to eq ["AccountingFeature"]
        end
      end
    end
    context "accounting/common/calc" do
      let(:rule_name) { "accounting/common/calc" }

      it "AccountingFeatureとCommonFeatureが返る" do
        expect(generator.send(:cam_features)).to eq %w[AccountingFeature CommonFeature]
      end
    end
  end

  # テストが難しいため
  # spec/generators/radd/rule_generator_spec.rbの
  # copy_ruleメソッドのテストで間接的にテストしたことにする
  # describe '#module_features'
end
