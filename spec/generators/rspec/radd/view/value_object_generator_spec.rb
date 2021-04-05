# frozen_string_literal: true

require "spec_helper"
require "generators/rspec/radd/view/value_object/value_object_generator"

RSpec.describe Rspec::Radd::View::Generators::ValueObjectGenerator, type: :generator do
  subject(:generator) { described_class.new([value_object]) }

  let(:value_object) { "title" }

  describe "#generate_file" do
    it "生成されるファイル名が_spec.rbで終わっている" do
      expect(generator.send(:generate_file, generator.send(:value_object))).to match(/_spec\.rb\z/)
    end
  end

  describe "#copy_value_object" do
    before do
      # rubocop:disable RSpec/SubjectStub
      allow(generator).to receive(:root_path).and_return("tmp/spec")
      # rubocop:enable RSpec/SubjectStub
    end

    let(:generated_files) { generator.send(:generate_file, generator.send(:value_object)) }

    shared_examples "ファイルが生成される" do |value_object_name, fixture|
      let(:value_object) { value_object_name }
      it do
        generator.copy_value_object
        expect(generator.send(:generate_file, generator.send(:value_object))).to generated_eq fixture
      end
    end
    context "bin/rails g radd:value_object title" do
      it_behaves_like("ファイルが生成される", "title", "spec/view/value_object/title_view_value_object.rb")
    end

    context "bin/rails g radd:value_object accounting_feature/title" do
      it_behaves_like("ファイルが生成される", "accounting_feature/title",
                      "spec/view/value_object/accounting_feature/title_view_value_object.rb")
    end
  end
end
