# frozen_string_literal: true

require "spec_helper"
require "generators/radd/swim_lane/swim_lane_generator"

RSpec.describe Radd::Generators::SwimLaneGenerator, type: :generator do
  subject(:generator) { described_class.new([swim_lane]) }

  let(:swim_lane) { "closing/user_actor" }

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
