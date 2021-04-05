# frozen_string_literal: true

require "spec_helper"
require "generators/radd/view/model/model_generator"

RSpec.describe Radd::ViewModelConcern do
  subject(:generator) { Radd::View::Generators::ModelGenerator.new([model]) }

  let(:model) { "title" }

  describe "#model" do
    %w[title title_view_model Title TitleViewModel
       accounting_feature/title_view_model
       AccountingFeature::TitleViewModel].each do |model_name|
      context "#{model_name}が指定された場合" do
        let(:model) { model_name }

        it "title_view_modelが返る" do
          expect(generator.send(:model)).to eq "title_view_model"
        end
      end
    end
  end

  describe "#cam_model" do
    %w[title title_view_model Title TitleViewModel
       accounting_feature/title_view_model
       AccountingFeature::TitleViewModel].each do |model_name|
      context "#{model_name}が指定された場合" do
        let(:model) { model_name }

        it "TitleViewModelが返る" do
          expect(generator.send(:cam_model)).to eq "TitleViewModel"
        end
      end
    end
  end
end
