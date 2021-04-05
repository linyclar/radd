# frozen_string_literal: true

require "spec_helper"
require "generators/rspec/radd/view/model/model_generator"

RSpec.describe Rspec::Radd::View::Generators::ModelGenerator, type: :generator do
  subject(:generator) { described_class.new([model]) }

  let(:model) { "title" }

  describe "#generate_file" do
    it "生成されるファイル名が_spec.rbで終わっている" do
      expect(generator.send(:generate_file, generator.send(:model))).to match(/_spec\.rb\z/)
    end
  end

  describe "#copy_model" do
    before do
      # rubocop:disable RSpec/SubjectStub
      allow(generator).to receive(:root_path).and_return("tmp/spec")
      # rubocop:enable RSpec/SubjectStub
    end

    let(:generated_files) { generator.send(:generate_file, generator.send(:model)) }

    shared_examples "ファイルが生成される" do |model_name, fixture|
      let(:model) { model_name }
      it do
        generator.copy_model
        expect(generator.send(:generate_file, generator.send(:model))).to generated_eq fixture
      end
    end
    context "bin/rails g radd:model title" do
      it_behaves_like("ファイルが生成される", "title", "spec/view/model/title_view_model.rb")
    end

    context "bin/rails g radd:model accounting_feature/title" do
      it_behaves_like("ファイルが生成される", "accounting_feature/title",
                      "spec/view/model/accounting_feature/title_view_model.rb")
    end
  end
end
