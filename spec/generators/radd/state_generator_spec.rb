# frozen_string_literal: true

require "spec_helper"
require "generators/radd/state/state_generator"

RSpec.describe Radd::Generators::StateGenerator, type: :generator do
  subject(:generator) { described_class.new(params) }

  let(:params) { [state, values].compact }
  let(:state) { "untreated" }
  let(:values) { nil }

  describe "#state" do
    %w[untreated untreated_state Untreated UntreatedState accounting_feature/untreated_state
       AccountingFeature::UntreatedState].each do |state_name|
      context "#{state_name}が指定された場合" do
        let(:state) { state_name }

        it "untreated_stateが返る" do
          expect(generator.send(:state)).to eq "untreated_state"
        end
      end
    end
  end

  describe "#cam_state" do
    %w[untreated untreated_state Untreated UntreatedState accounting_feature/untreated_state
       AccountingFeature::UntreatedState].each do |state_name|
      context "#{state_name}が指定された場合" do
        let(:state) { state_name }

        it "UntreatedStateが返る" do
          expect(generator.send(:cam_state)).to eq "UntreatedState"
        end
      end
    end
  end

  describe "#copy_state" do
    let(:generated_files) { generator.send(:generate_file, generator.send(:state)) }

    shared_examples "ファイルが生成される" do |state_name, fixture|
      let(:state) { state_name }
      it do
        generator.copy_state
        expect(generator.send(:generate_file, generator.send(:state))).to generated_eq fixture
      end
    end
    context "bin/rails g radd:state untreated" do
      it_behaves_like("ファイルが生成される", "untreated", "state/untreated_state.rb")
    end

    context "bin/rails g radd:state accounting_feature/untreated" do
      it_behaves_like("ファイルが生成される", "accounting_feature/untreated", "state/accounting_feature/untreated_state.rb")
    end

    context "bin/rails g radd:state untreated value1,value2" do
      let(:values) { "value1,value2" }

      it_behaves_like("ファイルが生成される", "untreated", "state/untreated_state_with_values.rb")
    end

    context "bin/rails g radd:state accounting_feature/untreated value1,value2" do
      let(:values) { "value1,value2" }

      it_behaves_like("ファイルが生成される", "accounting_feature/untreated",
                      "state/accounting_feature/untreated_state_with_values.rb")
    end
  end
end
