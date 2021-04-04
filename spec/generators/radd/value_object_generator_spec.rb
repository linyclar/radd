# frozen_string_literal: true

require "spec_helper"
require "generators/radd/value_object/value_object_generator"

RSpec.describe Radd::Generators::ValueObjectGenerator, type: :generator do
  subject(:generator) { described_class.new(params) }

  let(:params) { [value_object, values].compact }
  let(:value_object) { "title" }
  let(:values) { nil }

  describe "#copy_value_object" do
    let(:generated_files) { generator.send(:generate_file, generator.send(:value_object)) }

    shared_examples "ファイルが生成される" do |value_object_name, fixture|
      let(:value_object) { value_object_name }
      it do
        generator.copy_value_object
        expect(generator.send(:generate_file, generator.send(:value_object))).to generated_eq fixture
      end
    end
    context "bin/rails g radd:value_object title" do
      it_behaves_like("ファイルが生成される", "title", "value_object/title_value_object.rb")
    end

    context "bin/rails g radd:value_object accounting_feature/title" do
      it_behaves_like("ファイルが生成される", "accounting_feature/title", "value_object/accounting_feature/title_value_object.rb")
    end

    context "bin/rails g radd:value_object title value1,value2" do
      let(:values) { "value1,value2" }

      it_behaves_like("ファイルが生成される", "title", "value_object/title_value_object_with_values.rb")
    end

    context "bin/rails g radd:value_object accounting_feature/title value1,value2" do
      let(:values) { "value1,value2" }

      it_behaves_like("ファイルが生成される", "accounting_feature/title",
                      "value_object/accounting_feature/title_value_object_with_values.rb")
    end
  end
end
