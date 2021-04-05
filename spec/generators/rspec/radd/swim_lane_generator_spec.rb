# frozen_string_literal: true

require "spec_helper"
require "generators/rspec/radd/swim_lane/swim_lane_generator"

RSpec.describe Rspec::Radd::Generators::SwimLaneGenerator, type: :generator do
  subject(:generator) { described_class.new([swim_lane]) }

  let(:swim_lane) { "closing/user" }

  describe "#generate_file" do
    it "生成されるファイル名が_spec.rbで終わっている" do
      expect(generator.send(:generate_file)).to match(/_spec\.rb\z/)
    end
  end

  describe "#target_class" do
    shared_examples "モジュールを含めたクラス名が返る" do |swim_lane_name|
      let(:swim_lane) { swim_lane_name }
      let(:class_name) { [subject_name, "ClosingSwimLane", "UserActor"].reject(&:blank?).join("::") }
      it { expect(generator.send(:target_class)).to eq class_name }
    end
    context "subjectなしの場合" do
      let(:subject_name) { "" }

      %w[closing closing_swim_lane].each do |swim_lane_name|
        context "#{swim_lane_name}/user_actorが指定された場合" do
          it_behaves_like("モジュールを含めたクラス名が返る", "#{swim_lane_name}/user_actor")
        end
      end
      %w[Closing ClosingSwimLane].each do |swim_lane_name|
        context "#{swim_lane_name}::UserActorが指定された場合" do
          it_behaves_like("モジュールを含めたクラス名が返る", "#{swim_lane_name}::UserActor")
        end
      end
    end

    context "subjectありの場合" do
      let(:subject_name) { "AccountingSubject" }

      %w[closing closing_swim_lane].each do |swim_lane_name|
        context "accounting_subject/#{swim_lane_name}/user_actorが指定された場合" do
          it_behaves_like("モジュールを含めたクラス名が返る", "accounting_subject/#{swim_lane_name}/user_actor")
        end
      end
      %w[Closing ClosingSwimLane].each do |swim_lane_name|
        context "AccountingSubject::#{swim_lane_name}::UserActorが指定された場合" do
          it_behaves_like("モジュールを含めたクラス名が返る", "AccountingSubject::#{swim_lane_name}::UserActor")
        end
      end
    end
  end

  describe "#copy_swim_lane" do
    before do
      # rubocop:disable RSpec/SubjectStub
      allow(generator).to receive(:root_path).and_return("tmp/spec")
      # rubocop:enable RSpec/SubjectStub
    end

    let(:generated_files) { generator.send(:generate_file) }

    shared_examples "ファイルが生成される" do |swim_lane_name, fixture|
      let(:swim_lane) { swim_lane_name }
      it do
        generator.copy_swim_lane
        expect(generator.send(:generate_file)).to generated_eq fixture
      end
    end
    context "bin/rails g radd:swim_lane user_actor/closing" do
      it_behaves_like("ファイルが生成される", "closing/user_actor",
                      "spec/swim_lane/closing_swim_lane/user_actor.rb")
    end

    context "bin/rails g radd:swim_lane accounting_subject/user_actor/closing" do
      it_behaves_like("ファイルが生成される", "accounting_subject/closing/user_actor",
                      "spec/swim_lane/accounting_subject/closing_swim_lane/user_actor.rb")
    end
  end
end
