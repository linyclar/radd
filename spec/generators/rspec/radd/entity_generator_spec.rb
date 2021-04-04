# frozen_string_literal: true

require "spec_helper"
require "generators/rspec/radd/entity/entity_generator"

RSpec.describe Rspec::Radd::Generators::EntityGenerator, type: :generator do
  subject(:generator) { described_class.new([entity]) }

  let(:entity) { "title" }

  describe "#generate_file" do
    it "生成されるファイル名が_spec.rbで終わっている" do
      expect(generator.send(:generate_file, generator.send(:entity))).to match(/_spec\.rb\z/)
    end
  end

  describe "#copy_entity" do
    before do
      # rubocop:disable RSpec/SubjectStub
      allow(generator).to receive(:root_path).and_return("tmp/spec")
      # rubocop:enable RSpec/SubjectStub
    end

    let(:generated_files) { generator.send(:generate_file, generator.send(:entity)) }

    shared_examples "ファイルが生成される" do |entity_name, fixture|
      let(:entity) { entity_name }
      it do
        generator.copy_entity
        expect(generator.send(:generate_file, generator.send(:entity))).to generated_eq fixture
      end
    end
    context "bin/rails g radd:entity title" do
      it_behaves_like("ファイルが生成される", "title", "spec/entity/title_entity.rb")
    end

    context "bin/rails g radd:entity accounting_feature/title" do
      it_behaves_like("ファイルが生成される", "accounting_feature/title",
                      "spec/entity/accounting_feature/title_entity.rb")
    end
  end
end
