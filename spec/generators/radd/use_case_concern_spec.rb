# frozen_string_literal: true

require "spec_helper"
require "generators/radd/use_case/use_case_generator"

RSpec.describe Radd::UseCaseConcern do
  subject(:generator) { Radd::Generators::UseCaseGenerator.new([use_case]) }

  let(:use_case) { "closing" }

  describe "#generate_file" do
    shared_examples "生成先のパスが返る" do |use_case_name|
      let(:use_case) { use_case_name }
      let(:path) { "app/use_cases#{subject_path}#{actor_path}/closing_use_case.rb" }
      it { expect(generator.send(:generate_file)).to eq path }
    end

    context "subjectなしの場合" do
      let(:subject_path) { "" }
      let(:actor_path) { "" }

      %w[closing closing_use_case Closing ClosingUseCase].each do |use_case_name|
        context "#{use_case_name}が指定された場合" do
          it_behaves_like("生成先のパスが返る", use_case_name)
        end
      end
    end

    context "actorありの場合" do
      let(:subject_path) { "" }
      let(:actor_path) { "/user_actor" }

      %w[closing closing_use_case].each do |use_case_name|
        context "user_actor/#{use_case_name}が指定された場合" do
          it_behaves_like("生成先のパスが返る", "user_actor/#{use_case_name}")
        end
      end
      %w[Closing ClosingUseCase].each do |use_case_name|
        context "UserActor::#{use_case_name}が指定された場合" do
          it_behaves_like("生成先のパスが返る", "UserActor::#{use_case_name}")
        end
      end
    end

    context "subjectありの場合" do
      let(:subject_path) { "/accounting_subject" }
      let(:actor_path) { "/user_actor" }

      %w[closing closing_use_case].each do |use_case_name|
        context "accounting_subject/user_actor/#{use_case_name}が指定された場合" do
          it_behaves_like("生成先のパスが返る", "accounting_subject/user_actor/#{use_case_name}")
        end
      end
      %w[Closing ClosingUseCase].each do |use_case_name|
        context "AccountingSubject::UserActor::#{use_case_name}が指定された場合" do
          it_behaves_like("生成先のパスが返る", "AccountingSubject::UserActor::#{use_case_name}")
        end
      end
    end
  end

  describe "#use_case" do
    %w[closing closing_use_case Closing ClosingUseCase
       user_actor/closing_use_case UserActor::ClosingUseCase
       accounting_subject/user_actor/closing_use_case
       AccountingSubject::UserActor::ClosingUseCase].each do |use_case_name|
      context "#{use_case_name}が指定された場合" do
        let(:use_case) { use_case_name }

        it "closing_use_caseが返る" do
          expect(generator.send(:use_case)).to eq "closing_use_case"
        end
      end
    end
  end

  describe "#cam_use_case" do
    %w[closing closing_use_case Closing ClosingUseCase
       user_actor/closing_use_case UserActor::ClosingUseCase
       accounting_subject/user_actor/closing_use_case
       AccountingSubject::UserActor::ClosingUseCase].each do |use_case_name|
      context "#{use_case_name}が指定された場合" do
        let(:use_case) { use_case_name }

        it "ClosingUseCaseが返る" do
          expect(generator.send(:cam_use_case)).to eq "ClosingUseCase"
        end
      end
    end
  end

  describe "#actor" do
    %w[closing closing_use_case Closing ClosingUseCase].each do |use_case_name|
      context "#{use_case_name}が指定された場合" do
        let(:use_case) { use_case_name }

        it "空文字が返る" do
          expect(generator.send(:actor)).to eq ""
        end
      end
    end
    %w[user_actor/closing_use_case UserActor::ClosingUseCase
       accounting_subject/user_actor/closing_use_case
       AccountingSubject::UserActor::ClosingUseCase].each do |use_case_name|
      context "#{use_case_name}が指定された場合" do
        let(:use_case) { use_case_name }

        it "user_actorが返る" do
          expect(generator.send(:actor)).to eq "user_actor"
        end
      end
    end
  end
end
