# frozen_string_literal: true

require "spec_helper"
require "generators/rspec/radd/rule/rule_generator"

RSpec.describe Rspec::Radd::Generators::RuleGenerator, type: :generator do
  subject(:generator) { described_class.new([rule]) }

  let(:rule) { "calc" }

  describe "#generate_file" do
    it "生成されるファイル名が_spec.rbで終わっている" do
      expect(generator.send(:generate_file, generator.send(:rule))).to match(/_spec\.rb\z/)
    end
  end

  describe "#copy_rule" do
    before do
      # rubocop:disable RSpec/SubjectStub
      allow(generator).to receive(:root_path).and_return("tmp/spec")
      # rubocop:enable RSpec/SubjectStub
    end

    let(:generated_files) { generator.send(:generate_file, generator.send(:rule)) }

    shared_examples "ファイルが生成される" do |rule_name, fixture|
      let(:rule) { rule_name }
      it do
        generator.copy_rule
        expect(generator.send(:generate_file, generator.send(:rule))).to generated_eq fixture
      end
    end
    context "bin/rails g radd:rule calc" do
      it_behaves_like("ファイルが生成される", "calc", "spec/rule/calc_rule.rb")
    end

    context "bin/rails g radd:rule accounting_feature/calc" do
      it_behaves_like("ファイルが生成される", "accounting_feature/calc",
                      "spec/rule/accounting_feature/calc_rule.rb")
    end
  end
end
