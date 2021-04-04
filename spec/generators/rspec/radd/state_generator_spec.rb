# frozen_string_literal: true

require "spec_helper"
require "generators/rspec/radd/state/state_generator"

RSpec.describe Rspec::Radd::Generators::StateGenerator, type: :generator do
  subject(:generator) { described_class.new([state]) }

  let(:state) { "untreated" }

  describe "#generate_file" do
    it "生成されるファイル名が_spec.rbで終わっている" do
      expect(generator.send(:generate_file, generator.send(:state))).to match(/_spec\.rb\z/)
    end
  end

  describe "#copy_state" do
    before do
      # rubocop:disable RSpec/SubjectStub
      allow(generator).to receive(:root_path).and_return("tmp/spec")
      # rubocop:enable RSpec/SubjectStub
    end

    let(:generated_files) { generator.send(:generate_file, generator.send(:state)) }

    shared_examples "ファイルが生成される" do |state_name, fixture|
      let(:state) { state_name }
      it do
        generator.copy_state
        expect(generator.send(:generate_file, generator.send(:state))).to generated_eq fixture
      end
    end
    context "bin/rails g radd:state untreated" do
      it_behaves_like("ファイルが生成される", "untreated", "spec/state/untreated_state.rb")
    end

    context "bin/rails g radd:state accounting_feature/untreated" do
      it_behaves_like("ファイルが生成される", "accounting_feature/untreated",
                      "spec/state/accounting_feature/untreated_state.rb")
    end
  end
end
