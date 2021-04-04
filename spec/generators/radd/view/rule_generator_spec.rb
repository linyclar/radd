# frozen_string_literal: true

require "spec_helper"
require "generators/radd/view/rule/rule_generator"

RSpec.describe Radd::View::Generators::RuleGenerator, type: :generator do
  subject(:generator) { described_class.new(params) }

  let(:params) { [rule, values].compact }
  let(:rule) { "calc" }
  let(:values) { nil }

  describe "#copy_rule" do
    let(:generated_files) { generator.send(:generate_file, generator.send(:rule)) }

    shared_examples "ファイルが生成される" do |rule_name, fixture|
      let(:rule) { rule_name }
      it do
        generator.copy_rule
        expect(generator.send(:generate_file, generator.send(:rule))).to generated_eq fixture
      end
    end
    context "bin/rails g radd:view:rule calc" do
      it_behaves_like("ファイルが生成される", "calc", "view_model/rule/calc_view_rule.rb")
    end

    context "bin/rails g radd:view:rule accounting_feature/calc" do
      it_behaves_like("ファイルが生成される", "accounting_feature/calc", "view_model/rule/accounting_feature/calc_view_rule.rb")
    end

    context "bin/rails g radd:view:rule calc value1,value2" do
      let(:values) { "value1,value2" }

      it_behaves_like("ファイルが生成される", "calc", "view_model/rule/calc_view_rule_with_values.rb")
    end

    context "bin/rails g radd:view:rule accounting_feature/calc value1,value2" do
      let(:values) { "value1,value2" }

      it_behaves_like("ファイルが生成される", "accounting_feature/calc",
                      "view_model/rule/accounting_feature/calc_view_rule_with_values.rb")
    end
  end
end
