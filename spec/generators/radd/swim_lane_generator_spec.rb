# frozen_string_literal: true

require "spec_helper"
require "generators/radd/swim_lane/swim_lane_generator"

RSpec.describe Radd::Generators::SwimLaneGenerator, type: :generator do
  subject(:generator) { described_class.new([swim_lane]) }

  let(:swim_lane) { "closing/user_actor" }

  describe "#generate_file" do
    shared_examples "生成先のパスが返る" do |swim_lane_name|
      let(:swim_lane) { swim_lane_name }
      let(:path) { "app/use_cases#{subject_path}/closing_swim_lane/user_actor.rb" }
      it { expect(generator.send(:generate_file)).to eq path }
    end

    context "subjectなし、actorなしの場合" do
      let(:swim_lane) { "closing" }

      it "例外が返る" do
        expect { generator.send(:generate_file) }.to raise_error("スイムレーンとアクターを指定してください")
      end
    end

    context "subjectなしの場合" do
      let(:subject_path) { "" }

      %w[closing closing_swim_lane].each do |swim_lane_name|
        context "#{swim_lane_name}/user_actorが指定された場合" do
          it_behaves_like("生成先のパスが返る", "#{swim_lane_name}/user_actor")
        end
      end
      %w[Closing ClosingSwimLane].each do |swim_lane_name|
        context "#{swim_lane_name}::UserActorが指定された場合" do
          it_behaves_like("生成先のパスが返る", "#{swim_lane_name}::UserActor")
        end
      end
    end

    context "subjectありの場合" do
      let(:subject_path) { "/accounting_subject" }

      %w[closing closing_swim_lane].each do |swim_lane_name|
        context "accounting_subject/#{swim_lane_name}/user_actorが指定された場合" do
          it_behaves_like("生成先のパスが返る", "accounting_subject/#{swim_lane_name}/user_actor")
        end
      end
      %w[Closing ClosingSwimLane].each do |swim_lane_name|
        context "AccountingSubject::#{swim_lane_name}::UserActorが指定された場合" do
          it_behaves_like("生成先のパスが返る", "AccountingSubject::#{swim_lane_name}::UserActor")
        end
      end
    end
  end

  describe "#swim_lane" do
    %w[closing_swim_lane/user_actor ClosingSwimLane::UserActor
       accounting_subject/closing_swim_lane/user_actor
       AccountingSubject::ClosingSwimLane::UserActor].each do |swim_lane_name|
      context "#{swim_lane_name}が指定された場合" do
        let(:swim_lane) { swim_lane_name }

        it "closing_swim_laneが返る" do
          expect(generator.send(:swim_lane)).to eq "closing_swim_lane"
        end
      end
    end
  end

  describe "#cam_swim_lane" do
    %w[closing_swim_lane/user_actor ClosingSwimLane::UserActor
       accounting_subject/closing_swim_lane/user_actor
       AccountingSubject::ClosingSwimLane::UserActor].each do |swim_lane_name|
      context "#{swim_lane_name}が指定された場合" do
        let(:swim_lane) { swim_lane_name }

        it "ClosingSwimLaneが返る" do
          expect(generator.send(:cam_swim_lane)).to eq "ClosingSwimLane"
        end
      end
    end
  end

  describe "#actor" do
    %w[closing_swim_lane/user_actor ClosingSwimLane::UserActor
       accounting_subject/closing_swim_lane/user_actor
       AccountingSubject::ClosingSwimLane::UserActor].each do |swim_lane_name|
      context "#{swim_lane_name}が指定された場合" do
        let(:swim_lane) { swim_lane_name }

        it "user_actorが返る" do
          expect(generator.send(:actor)).to eq "user_actor"
        end
      end
    end
  end

  describe "#copy_swim_lane" do
    let(:generated_files) { generator.send(:generate_file) }

    shared_examples "ファイルが生成される" do |swim_lane_name, fixture|
      let(:swim_lane) { swim_lane_name }
      it do
        generator.copy_swim_lane
        expect(generator.send(:generate_file)).to generated_eq fixture
      end
    end
    context "bin/rails g radd:swim_lane closing/user_actor" do
      it_behaves_like("ファイルが生成される", "closing/user_actor", "swim_lane/closing_swim_lane/user_actor.rb")
    end

    context "bin/rails g radd:swim_lane accounting_subject/closing/user_actor" do
      it_behaves_like("ファイルが生成される", "accounting_subject/closing/user_actor",
                      "swim_lane/accounting_subject/closing_swim_lane/user_actor.rb")
    end
  end
end
