# frozen_string_literal: true

require "spec_helper"
require "generators/radd/rule/rule_generator"

RSpec.describe Radd::ParamsOptionConcern do
  subject(:generator) { Radd::Generators::RuleGenerator.new(["calc", params].compact) }

  let(:params) { nil }

  describe "#attr_accessor_params" do
    subject { generator.send(:attr_accessor_params) }

    context "params = ''" do
      let(:params) { "" }

      it { is_expected.to eq nil }
    end

    context "params = field1" do
      let(:params) { "field1" }

      it { is_expected.to eq "attr_accessor :field1" }
    end

    context "params = field1,field2" do
      let(:params) { "field1,field2" }

      it { is_expected.to eq "attr_accessor :field1, :field2" }
    end
  end

  describe "#def_initialize" do
    subject { generator.send(:def_initialize) }

    context "params = ''" do
      let(:params) { "" }
      let(:def_initialize) do
        <<~DEF
          def initialize
          end
        DEF
      end

      it { is_expected.to eq def_initialize }
    end

    context "params = field1" do
      let(:params) { "field1" }
      let(:def_initialize) do
        <<~DEF
          def initialize(field1)
            self.field1 = field1
          end
        DEF
      end

      it { is_expected.to eq def_initialize }
    end

    context "params = field1,field2" do
      let(:params) { "field1,field2" }
      let(:def_initialize) do
        <<~DEF
          def initialize(field1, field2)
            self.field1 = field1
            self.field2 = field2
          end
        DEF
      end

      it { is_expected.to eq def_initialize }
    end
  end

  describe "#params" do
    subject { generator.send(:params) }

    context "params = ''" do
      let(:params) { "" }

      it { is_expected.to eq [] }
    end

    context "params = field1" do
      let(:params) { "field1" }

      it { is_expected.to eq ["field1"] }
    end

    context "params = field1,field2" do
      let(:params) { "field1,field2" }

      it { is_expected.to eq %w[field1 field2] }
    end
  end
end
