# frozen_string_literal: true

require "spec_helper"
require "generators/radd/entity/entity_generator"

RSpec.describe Radd::Generators::EntityGenerator, type: :generator do
  subject(:generator) { described_class.new(params, options) }

  let(:params) { [entity, values].compact }
  let(:entity) { "title" }
  let(:values) { nil }
  let(:options) { {} }

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

  describe "#model_file_path" do
    context "モデルの指定がない場合" do
      it "空文字が返る" do
        expect(generator.send(:model_file_path)).to eq ""
      end
    end

    context "モデルの指定がある場合" do
      %w[user users User Users].each do |model_name|
        context "#{model_name}を指定した場合" do
          let(:options) { { model: model_name } }

          it "指定したモデルのファイルパスが返る" do
            expect(generator.send(:model_file_path)).to eq "app/models/user.rb"
          end
        end
      end
    end
  end

  describe "#features_string" do
    context "featureの指定がない場合" do
      it "entityが返る" do
        expect(generator.send(:features_string)).to eq "entity"
      end
    end

    context "1階層のfeatureの指定がある場合" do
      let(:entity) { "accounting/title" }

      it "feature名_featureが返る" do
        expect(generator.send(:features_string)).to eq "accounting_feature"
      end
    end

    context "2階層のfeatureの指定がある場合" do
      let(:entity) { "accounting/common/title" }

      it "1階層目のfeature名_2階層目のfeature名_fieatureが返る" do
        expect(generator.send(:features_string)).to eq "accounting_common_feature"
      end
    end
  end

  describe "#copy_entity" do
    let(:generated_files) { generator.send(:generate_file, generator.send(:entity)) }

    shared_examples "ファイルが生成される" do |entity_name, fixture|
      let(:entity) { entity_name }
      it do
        generator.copy_entity
        expect(generator.send(:generate_file, generator.send(:entity))).to generated_eq fixture
      end
    end
    context "bin/rails g radd:entity title" do
      it_behaves_like("ファイルが生成される", "title", "entity/title.rb")
    end

    context "bin/rails g radd:entity title -d field1,field2" do
      let(:options) { { delegate: "field1,field2" } }

      it_behaves_like("ファイルが生成される", "title", "entity/title_with_delegate.rb")
    end

    context "bin/rails g radd:entity accounting_feature/title" do
      it_behaves_like("ファイルが生成される", "accounting_feature/title", "entity/accounting_feature/title.rb")
    end

    context "bin/rails g radd:entity accounting_feature/title -d field1,field2" do
      let(:options) { { delegate: "field1,field2" } }

      it_behaves_like("ファイルが生成される", "accounting_feature/title", "entity/accounting_feature/title_with_delegate.rb")
    end
  end

  # rubocop:disable RSpec/SubjectStub
  describe "#inject_model" do
    before do
      allow(generator).to receive(:insert_into_file).and_return(nil)
    end

    context "モデルの指定がない場合" do
      it "nilが返る" do
        expect(generator.send(:inject_model)).to eq nil
      end
    end

    context "モデルの指定がある場合" do
      let(:options) { { model: "user" } }
      let(:method) do
        <<~DEF
          def to_entity
            ::Title.new(self)
          end
        DEF
      end

      it "モデルにメソッドが追加される" do
        file = "app/models/user.rb"
        generator.send(:inject_model)
        expect(generator).to have_received(:insert_into_file).with(file, generator.send(:indent, method),
                                                                   before: /^end$/)
      end

      context "featureの指定がある場合" do
        let(:entity) { "accounting/title" }
        let(:method) do
          <<~DEF
            def to_accounting_feature
              AccountingFeature::Title.new(self)
            end
          DEF
        end

        it "モデルにfeature名つきのメソッドが追加される" do
          file = "app/models/user.rb"
          generator.send(:inject_model)
          expect(generator).to have_received(:insert_into_file).with(file, generator.send(:indent, method),
                                                                     before: /^end$/)
        end
      end
    end
  end
  # rubocop:enable RSpec/SubjectStub
end
