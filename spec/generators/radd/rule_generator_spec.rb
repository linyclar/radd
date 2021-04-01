# frozen_string_literal: true

require "spec_helper"
require "generators/radd/rule/rule_generator"

RSpec.describe Radd::Generators::RuleGenerator, type: :generator do
  subject(:generator) { described_class.new(params) }

  let(:params) { [rule, values].compact }
  let(:rule) { "calc" }
  let(:values) { nil }

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

  describe "#generate_file" do
    shared_examples "生成先のパスが返る" do |rule_name|
      let(:rule) { rule_name }
      let(:path) { "app/domains#{feature_path}/calc_rule.rb" }
      it { expect(generator.send(:generate_file)).to eq path }
    end

    context "featureなしの場合" do
      let(:feature_path) { "" }

      %w[calc calc_rule Calc CalcRule].each do |rule_name|
        context "#{rule_name}が指定された場合" do
          it_behaves_like("生成先のパスが返る", rule_name)
        end
      end
    end

    context "featureありの場合" do
      let(:feature_path) { "/accounting_feature" }

      %w[calc calc_rule].each do |rule_name|
        context "accounting_feature/#{rule_name}が指定された場合" do
          it_behaves_like("生成先のパスが返る", "accounting_feature/#{rule_name}")
        end
      end
      %w[Calc CalcRule].each do |rule_name|
        context "AccountingFeature::#{rule_name}が指定された場合" do
          it_behaves_like("生成先のパスが返る", "AccountingFeature::#{rule_name}")
        end
      end
    end
  end

  describe "#copy_rule" do
    let(:generated_files) { generator.send(:generate_file) }

    shared_examples "ファイルが生成される" do |rule_name, fixture|
      let(:rule) { rule_name }
      it do
        generator.copy_rule
        expect(generator.send(:generate_file)).to generated_eq fixture
      end
    end
    context "bin/rails g radd:rule calc" do
      it_behaves_like("ファイルが生成される", "calc", "rule/calc_rule.rb")
    end

    context "bin/rails g radd:rule accounting_feature/calc" do
      it_behaves_like("ファイルが生成される", "accounting_feature/calc", "rule/accounting_feature/calc_rule.rb")
    end

    context "bin/rails g radd:rule calc value1,value2" do
      let(:values) { "value1,value2" }

      it_behaves_like("ファイルが生成される", "calc", "rule/calc_rule_with_values.rb")
    end

    context "bin/rails g radd:rule accounting_feature/calc value1,value2" do
      let(:values) { "value1,value2" }

      it_behaves_like("ファイルが生成される", "accounting_feature/calc", "rule/accounting_feature/calc_rule_with_values.rb")
    end
  end
end
