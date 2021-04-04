# frozen_string_literal: true

require "spec_helper"
require "generators/radd/value_object/value_object_generator"

RSpec.describe Radd::ValueObjectConcern do
  subject(:generator) { Radd::Generators::ValueObjectGenerator.new([value_object]) }

  let(:value_object) { "title" }

  describe "#value_object" do
    %w[title title_value_object Title TitleValueObject accounting_feature/title_value_object
       AccountingFeature::TitleValueObject].each do |value_object_name|
      context "#{value_object_name}が指定された場合" do
        let(:value_object) { value_object_name }

        it "title_value_objectが返る" do
          expect(generator.send(:value_object)).to eq "title_value_object"
        end
      end
    end
  end

  describe "#cam_value_object" do
    %w[title title_value_object Title TitleValueObject accounting_feature/title_value_object
       AccountingFeature::TitleValueObject].each do |value_object_name|
      context "#{value_object_name}が指定された場合" do
        let(:value_object) { value_object_name }

        it "TitleValueObjectが返る" do
          expect(generator.send(:cam_value_object)).to eq "TitleValueObject"
        end
      end
    end
  end
end
