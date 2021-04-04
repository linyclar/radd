# frozen_string_literal: true

require "spec_helper"
require "generators/rspec/radd/event/event_generator"

RSpec.describe Rspec::Radd::Generators::EventGenerator, type: :generator do
  subject(:generator) { described_class.new([event]) }

  let(:event) { "settlement" }

  describe "#generate_file" do
    it "生成されるファイル名が_spec.rbで終わっている" do
      expect(generator.send(:generate_file, generator.send(:event))).to match(/_spec\.rb\z/)
    end
  end

  describe "#copy_event" do
    before do
      # rubocop:disable RSpec/SubjectStub
      allow(generator).to receive(:root_path).and_return("tmp/spec")
      # rubocop:enable RSpec/SubjectStub
    end

    let(:generated_files) { generator.send(:generate_file, generator.send(:event)) }

    shared_examples "ファイルが生成される" do |event_name, fixture|
      let(:event) { event_name }
      it do
        generator.copy_event
        expect(generator.send(:generate_file, generator.send(:event))).to generated_eq fixture
      end
    end
    context "bin/rails g radd:event settlement" do
      it_behaves_like("ファイルが生成される", "settlement", "spec/event/settlement_event.rb")
    end

    context "bin/rails g radd:event accounting_feature/settlement" do
      it_behaves_like("ファイルが生成される", "accounting_feature/settlement",
                      "spec/event/accounting_feature/settlement_event.rb")
    end
  end
end
