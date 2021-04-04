# frozen_string_literal: true

require "spec_helper"
require "generators/radd/view/state/state_generator"

RSpec.describe Radd::View::Generators::StateGenerator, type: :generator do
  subject(:generator) { described_class.new(params) }

  let(:params) { [state, values].compact }
  let(:state) { "unteated" }
  let(:values) { nil }

  describe "#copy_state" do
    let(:generated_files) { generator.send(:generate_file, generator.send(:state)) }

    shared_examples "ファイルが生成される" do |state_name, fixture|
      let(:state) { state_name }
      it do
        generator.copy_state
        expect(generator.send(:generate_file, generator.send(:state))).to generated_eq fixture
      end
    end
    context "bin/rails g radd:view:state unteated" do
      it_behaves_like("ファイルが生成される", "unteated", "view_model/state/unteated_view_state.rb")
    end

    context "bin/rails g radd:view:state accounting_feature/unteated" do
      it_behaves_like("ファイルが生成される", "accounting_feature/unteated",
                      "view_model/state/accounting_feature/unteated_view_state.rb")
    end

    context "bin/rails g radd:view:state unteated value1,value2" do
      let(:values) { "value1,value2" }

      it_behaves_like("ファイルが生成される", "unteated", "view_model/state/unteated_view_state_with_values.rb")
    end

    context "bin/rails g radd:view:state accounting_feature/unteated value1,value2" do
      let(:values) { "value1,value2" }

      it_behaves_like("ファイルが生成される", "accounting_feature/unteated",
                      "view_model/state/accounting_feature/unteated_view_state_with_values.rb")
    end
  end
end
