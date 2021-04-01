# frozen_string_literal: true

require "spec_helper"
require "generators/radd/event/event_generator"

RSpec.describe Radd::Generators::EventGenerator, type: :generator do
  subject(:generator) { described_class.new(params) }

  let(:params) { [event, values].compact }
  let(:event) { "settlement" }
  let(:values) { nil }

  describe "#event" do
    %w[settlement settlement_event Settlement SettlementEvent accounting_feature/settlement_event
       AccountingFeature::SettlementEvent].each do |event_name|
      context "#{event_name}が指定された場合" do
        let(:event) { event_name }

        it "settlement_eventが返る" do
          expect(generator.send(:event)).to eq "settlement_event"
        end
      end
    end
  end

  describe "#cam_event" do
    %w[settlement settlement_event Settlement SettlementEvent accounting_feature/settlement_event
       AccountingFeature::SettlementEvent].each do |event_name|
      context "#{event_name}が指定された場合" do
        let(:event) { event_name }

        it "SettlementEventが返る" do
          expect(generator.send(:cam_event)).to eq "SettlementEvent"
        end
      end
    end
  end

  describe "#copy_event" do
    let(:generated_files) { generator.send(:generate_file, generator.send(:event)) }

    shared_examples "ファイルが生成される" do |event_name, fixture|
      let(:event) { event_name }
      it do
        generator.copy_event
        expect(generator.send(:generate_file, generator.send(:event))).to generated_eq fixture
      end
    end
    context "bin/rails g radd:event settlement" do
      it_behaves_like("ファイルが生成される", "settlement", "event/settlement_event.rb")
    end

    context "bin/rails g radd:event accounting_feature/settlement" do
      it_behaves_like("ファイルが生成される", "accounting_feature/settlement", "event/accounting_feature/settlement_event.rb")
    end

    context "bin/rails g radd:event settlement value1,value2" do
      let(:values) { "value1,value2" }

      it_behaves_like("ファイルが生成される", "settlement", "event/settlement_event_with_values.rb")
    end

    context "bin/rails g radd:event accounting_feature/settlement value1,value2" do
      let(:values) { "value1,value2" }

      it_behaves_like("ファイルが生成される", "accounting_feature/settlement",
                      "event/accounting_feature/settlement_event_with_values.rb")
    end
  end
end
