# frozen_string_literal: true

require "spec_helper"
require "generators/radd/state/state_generator"

RSpec.describe Radd::StateConcern do
  subject(:generator) { Radd::Generators::StateGenerator.new([state]) }

  let(:state) { "calc" }

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
end
