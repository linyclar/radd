# frozen_string_literal: true

require "spec_helper"
require "generators/radd/use_case/use_case_generator"

RSpec.describe Radd::UseCaseConcern do
  subject(:generator) { Radd::Generators::UseCaseGenerator.new([use_case_name]) }

  let(:use_case_name) { "foo" }

  describe "#subjects" do
    context "bin/rails g radd:use_case foo" do
      let(:use_case_name) { "foo" }

      it "空配列が返る" do
        expect(generator.send(:subjects)).to eq []
      end
    end

    context "bin/rails g radd:use_case user/foo" do
      let(:use_case_name) { "user/foo" }

      it "空配列が返る" do
        expect(generator.send(:subjects)).to eq []
      end
    end

    context "bin/rails g radd:use_case accounting/user/foo" do
      let(:use_case_name) { "accounting/user/foo" }

      it "['accounting_subject']が返る" do
        expect(generator.send(:subjects)).to eq ["accounting_subject"]
      end
    end

    context "bin/rails g radd:use_case accounting/common/user/foo" do
      let(:use_case_name) { "accounting/common/user/foo" }

      it "['accounting_subject', 'common_subject']が返る" do
        expect(generator.send(:subjects)).to eq %w[accounting_subject common_subject]
      end
    end
  end

  describe "#cam_subjects" do
    context "bin/rails g radd:use_case foo" do
      let(:use_case_name) { "foo" }

      it "空配列が返る" do
        expect(generator.send(:cam_subjects)).to eq []
      end
    end

    context "bin/rails g radd:use_case user/foo" do
      let(:use_case_name) { "user/foo" }

      it "空配列が返る" do
        expect(generator.send(:cam_subjects)).to eq []
      end
    end

    context "bin/rails g radd:use_case accounting/user/foo" do
      let(:use_case_name) { "accounting/user/foo" }

      it "['AccountingSubject']が返る" do
        expect(generator.send(:cam_subjects)).to eq ["AccountingSubject"]
      end
    end

    context "bin/rails g radd:use_case accounting/common/user/foo" do
      let(:use_case_name) { "accounting/common/user/foo" }

      it "['AccountingSubject', 'CommonSubject']が返る" do
        expect(generator.send(:cam_subjects)).to eq %w[AccountingSubject CommonSubject]
      end
    end
  end

  describe "#cam_actor" do
    %w[closing closing_use_case Closing ClosingUseCase].each do |use_case_name|
      context "#{use_case_name}が指定された場合" do
        let(:use_case) { use_case_name }

        it "空文字が返る" do
          expect(generator.send(:cam_actor)).to eq ""
        end
      end
    end
    %w[user_actor/closing_use_case UserActor::ClosingUseCase
       accounting_subject/user_actor/closing_use_case AccountingSubject::UserActor::ClosingUseCase].each do |use_case|
      context "#{use_case}が指定された場合" do
        let(:use_case_name) { use_case }

        it "UserActorが返る" do
          expect(generator.send(:cam_actor)).to eq "UserActor"
        end
      end
    end
  end

  # rubocop:disable RSpec/SubjectStub
  describe "#module_subjects" do
    let(:body) do
      <<~BODY
        class UseCase
          def initialize
          end
        end
      BODY
    end

    before do
      allow(generator).to receive(:capture).and_return(generator.send(:indent, body))
      allow(generator).to receive(:concat).and_return("")
    end

    context "subjectなしアクターなしの場合" do
      let(:use_case_name) { "use_case" }

      it "subjectモジュールなしのクラス定義文字列が返る" do
        generator.send(:module_subjects)
        expect(generator).to have_received(:concat).with(body.chomp)
      end
    end

    context "Actorがある場合" do
      let(:use_case_name) { "user_actor/use_case" }
      let(:result) do
        # module actorは別メソッドで出力される
        <<~BODY
          class UseCase
            def initialize
            end
          end
        BODY
      end

      it "subjectモジュールありのクラス定義文字列が返る" do
        generator.send(:module_subjects)
        expect(generator).to have_received(:concat).with(result.chomp)
      end
    end

    context "subjectとActorがある場合" do
      let(:use_case_name) { "accounting_subject/user_actor/use_case" }
      let(:result) do
        # module actorは別メソッドで出力される
        <<~BODY
          module AccountingSubject
            class UseCase
              def initialize
              end
            end
          end
        BODY
      end

      it "subjectモジュールありのクラス定義文字列が返る" do
        generator.send(:module_subjects)
        expect(generator).to have_received(:concat).with(result.chomp)
      end
    end
  end
  # rubocop:enable RSpec/SubjectStub
end
