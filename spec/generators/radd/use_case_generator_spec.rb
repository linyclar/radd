# frozen_string_literal: true

require "spec_helper"
require "generators/radd/use_case/use_case_generator"

RSpec.describe Radd::Generators::UseCaseGenerator, type: :generator do
  subject(:generator) { described_class.new([use_case]) }

  # rubocop:disable RSpec/SubjectStub
  describe "#module_actor" do
    let(:body) do
      <<~BODY
        class ClosingUseCase
        end
      BODY
    end

    before do
      allow(generator).to receive(:capture).and_return(generator.send(:indent, body))
      allow(generator).to receive(:concat).and_return("")
    end

    context "actorがない場合" do
      let(:use_case) { "closing" }

      it "モジュールなしのクラス定義文字列が返る" do
        generator.send(:module_actor)
        expect(generator).to have_received(:concat).with(body)
      end
    end

    context "actorがある場合" do
      let(:use_case) { "user/closing" }
      let(:result) do
        <<~DEF
          module UserActor
            class ClosingUseCase
            end
          end
        DEF
      end

      it "モジュールありのクラス定義文字列が返る" do
        generator.send(:module_actor)
        expect(generator).to have_received(:concat).with(result)
      end
    end
  end
  # rubocop:enable RSpec/SubjectStub

  describe "#def_initialize" do
    context "actorがない場合" do
      let(:use_case) { "closing" }
      let(:result) do
        <<~DEF
          def initialize
          end
        DEF
      end

      it "引数なしのコンストラクタ文字列が返る" do
        expect(generator.send(:def_initialize)).to eq result
      end
    end

    context "actorがある場合" do
      let(:use_case) { "user/closing" }
      let(:result) do
        <<~DEF
          attr_accessor :actor

          def initialize(actor)
            self.actor = actor
          end
        DEF
      end

      it "引数ありのコンストラクタ文字列が返る" do
        expect(generator.send(:def_initialize)).to eq result
      end
    end
  end

  describe "#copy_use_case" do
    let(:generated_files) { generator.send(:generate_file) }

    shared_examples "ファイルが生成される" do |use_case_name, fixture|
      let(:use_case) { use_case_name }
      it do
        generator.copy_use_case
        expect(generator.send(:generate_file)).to generated_eq fixture
      end
    end
    context "bin/rails g radd:use_case closing" do
      it_behaves_like("ファイルが生成される", "closing", "use_case/closing_use_case.rb")
    end

    context "bin/rails g radd:use_case user_actor/closing" do
      it_behaves_like("ファイルが生成される", "user_actor/closing", "use_case/user_actor/closing_use_case.rb")
    end

    context "bin/rails g radd:use_case accounting_subject/user_actor/closing" do
      it_behaves_like("ファイルが生成される", "accounting_subject/user_actor/closing",
                      "use_case/accounting_subject/user_actor/closing_use_case.rb")
    end
  end
end
