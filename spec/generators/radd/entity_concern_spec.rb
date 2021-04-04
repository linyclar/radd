# frozen_string_literal: true

require "spec_helper"
require "generators/radd/event/event_generator"

RSpec.describe Radd::EventConcern do
  subject(:generator) { Radd::Generators::EntityGenerator.new([entity]) }

  let(:entity) { "title" }

  describe "#entity" do
    %w[title title_entity Title TitleEntity accounting_feature/title_entity
       AccountingFeature::TitleEntity].each do |entity_name|
      context "#{entity_name}が指定された場合" do
        let(:entity) { entity_name }

        it "指定した内容のスネークケースが返る" do
          underscore = entity_name.split("/").last.split("::").last.underscore
          expect(generator.send(:entity)).to eq underscore
        end
      end
    end
  end

  describe "#cam_entity" do
    %w[title title_entity Title TitleEntity accounting_feature/title_entity
       AccountingFeature::TitleEntity].each do |entity_name|
      context "#{entity_name}が指定された場合" do
        let(:entity) { entity_name }

        it "指定した内容のキャメルケースが返る" do
          camelcase = entity_name.split("/").last.split("::").last.camelize
          expect(generator.send(:cam_entity)).to eq camelcase
        end
      end
    end
  end
end
