# frozen_string_literal: true

require "spec_helper"
require "generators/rspec/radd/use_case/use_case_generator"

RSpec.describe Rspec::Radd::Generators::UseCaseGenerator, type: :generator do
  subject(:generator) { described_class.new([use_case]) }

  let(:use_case) { "closing" }

  describe "#generate_file" do
    it "生成されるファイル名が_spec.rbで終わっている" do
      expect(generator.send(:generate_file)).to match(/_spec\.rb\z/)
    end
  end

  describe "#target_class" do
    shared_examples "モジュールを含めたクラス名が返る" do |use_case_name|
      let(:use_case) { use_case_name }
      let(:class_name) { [subject_name, actor_name, "ClosingUseCase"].reject(&:blank?).join("::") }
      it { expect(generator.send(:target_class)).to eq class_name }
    end
    context "subjectなしの場合" do
      let(:subject_name) { "" }
      let(:actor_name) { "" }

      %w[closing closing_use_case Closing ClosingUseCase].each do |use_case_name|
        context "#{use_case_name}が指定された場合" do
          it_behaves_like("モジュールを含めたクラス名が返る", use_case_name)
        end
      end
    end

    context "actorありの場合" do
      let(:subject_name) { "" }
      let(:actor_name) { "UserActor" }

      %w[closing closing_use_case].each do |use_case_name|
        context "user_actor/#{use_case_name}が指定された場合" do
          it_behaves_like("モジュールを含めたクラス名が返る", "user_actor/#{use_case_name}")
        end
      end
      %w[Closing ClosingUseCase].each do |use_case_name|
        context "UserActor::#{use_case_name}が指定された場合" do
          it_behaves_like("モジュールを含めたクラス名が返る", "UserActor::#{use_case_name}")
        end
      end
    end

    context "subjectありの場合" do
      let(:subject_name) { "AccountingSubject" }
      let(:actor_name) { "UserActor" }

      %w[closing closing_use_case].each do |use_case_name|
        context "accounting_subject/user_actor/#{use_case_name}が指定された場合" do
          it_behaves_like("モジュールを含めたクラス名が返る", "accounting_subject/user_actor/#{use_case_name}")
        end
      end
      %w[Closing ClosingUseCase].each do |use_case_name|
        context "AccountingSubject::UserActor::#{use_case_name}が指定された場合" do
          it_behaves_like("モジュールを含めたクラス名が返る", "AccountingSubject::UserActor::#{use_case_name}")
        end
      end
    end
  end

  describe "#copy_use_case" do
    before do
      # rubocop:disable RSpec/SubjectStub
      allow(generator).to receive(:root_path).and_return("tmp/spec")
      # rubocop:enable RSpec/SubjectStub
    end

    let(:generated_files) { generator.send(:generate_file) }

    shared_examples "ファイルが生成される" do |use_case_name, fixture|
      let(:use_case) { use_case_name }
      it do
        generator.copy_use_case
        expect(generator.send(:generate_file)).to generated_eq fixture
      end
    end
    context "bin/rails g radd:use_case closing" do
      it_behaves_like("ファイルが生成される", "closing", "spec/use_case/closing_use_case.rb")
    end

    context "bin/rails g radd:use_case user_actor/closing" do
      it_behaves_like("ファイルが生成される", "user_actor/closing",
                      "spec/use_case/user_actor/closing_use_case.rb")
    end

    context "bin/rails g radd:use_case accounting_subject/user_actor/closing" do
      it_behaves_like("ファイルが生成される", "accounting_subject/user_actor/closing",
                      "spec/use_case/accounting_subject/user_actor/closing_use_case.rb")
    end
  end
end
