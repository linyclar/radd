# frozen_string_literal: true

require "spec_helper"
require "generators/radd/view/model/model_generator"

RSpec.describe Radd::View::Generators::ModelGenerator, type: :generator do
  subject(:generator) { described_class.new([model], options) }

  let(:model) { "title" }
  let(:options) { {} }

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

  describe "#copy_model" do
    let(:generated_files) { generator.send(:generate_file, generator.send(:model)) }

    shared_examples "ファイルが生成される" do |model_name, fixture|
      let(:model) { model_name }
      it do
        generator.copy_model
        expect(generator.send(:generate_file, generator.send(:model))).to generated_eq fixture
      end
    end
    context "bin/rails g radd:view:model title" do
      it_behaves_like("ファイルが生成される", "title", "view_model/model/title_view_model.rb")
    end

    context "bin/rails g radd:view:model title -d field1,field2" do
      let(:options) { { delegate: "field1,field2" } }

      it_behaves_like("ファイルが生成される", "title", "view_model/model/title_view_model_with_delegate.rb")
    end

    context "bin/rails g radd:view:model accounting_feature/title" do
      it_behaves_like("ファイルが生成される", "accounting_feature/title",
                      "view_model/model/accounting_feature/title_view_model.rb")
    end

    context "bin/rails g radd:view:model accounting_feature/title -d field1,field2" do
      let(:options) { { delegate: "field1,field2" } }

      it_behaves_like("ファイルが生成される", "accounting_feature/title",
                      "view_model/model/accounting_feature/title_view_model_with_delegate.rb")
    end
  end
end
