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

  describe "#generate_file" do
    shared_examples "生成先のパスが返る" do |rule|
      let(:rule_name) { rule }
      let(:path) { "app/domains#{feature_path}/calc_rule.rb" }
      it { expect(generator.send(:generate_file, "calc_rule")).to eq path }
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

  # rubocop:disable RSpec/SubjectStub
  describe "#module_features" do
    let(:body) do
      <<~BODY
        class Foo
          def initialize
          end
        end
      BODY
    end

    before do
      allow(generator).to receive(:capture).and_return(generator.send(:indent, body))
      allow(generator).to receive(:concat).and_return("")
    end

    context "featureなしの場合" do
      let(:rule_name) { "calc" }

      it "featureモジュールなしのクラス定義文字列が返る" do
        generator.send(:module_features)
        expect(generator).to have_received(:concat).with(body.chomp)
      end
    end

    context "featureが1段ある場合" do
      let(:rule_name) { "accounting/calc" }
      let(:result) do
        <<~BODY
          module AccountingFeature
            class Foo
              def initialize
              end
            end
          end
        BODY
      end

      it "featureモジュールありのクラス定義文字列が返る" do
        generator.send(:module_features)
        expect(generator).to have_received(:concat).with(result.chomp)
      end
    end

    context "featureが2段ある場合" do
      let(:rule_name) { "accounting/common/calc" }
      let(:result) do
        <<~BODY
          module AccountingFeature
            module CommonFeature
              class Foo
                def initialize
                end
              end
            end
          end
        BODY
      end

      it "featureモジュールありのクラス定義文字列が返る" do
        generator.send(:module_features)
        expect(generator).to have_received(:concat).with(result.chomp)
      end
    end
  end
  # rubocop:enable RSpec/SubjectStub
end
