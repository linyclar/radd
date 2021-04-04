# frozen_string_literal: true

require "spec_helper"
require "generators/radd/event/event_generator"

RSpec.describe Radd::EventConcern do
  subject(:generator) { Radd::Generators::EventGenerator.new([event]) }

  let(:event) { "calc" }

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
end
