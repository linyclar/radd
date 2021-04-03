# frozen_string_literal: true

require "spec_helper"
require "generators/radd/entity/entity_generator"

RSpec.describe Radd::DelegateOptionConcern do
  subject(:generator) { Radd::Generators::EntityGenerator.new(["title"], options) }

  let(:options) { {} }

  describe "#delegate_to" do
    context "delegateの指定がない場合" do
      it "nilが返る" do
        expect(generator.send(:delegate_to)).to eq nil
      end
    end

    context "delegateの指定がある場合" do
      let(:options) { { delegate: "field" } }

      it "delegate定義が返る" do
        string = "delegate :field, to: :raw\n"
        expect(generator.send(:delegate_to)).to eq string
      end
    end
  end

  describe "#delegate_options" do
    context "delegateの指定がない場合" do
      it "[]が返る" do
        expect(generator.send(:delegate_options)).to eq []
      end
    end

    context "delegateの指定がある場合" do
      context "単一のフィールドを指定された場合" do
        let(:options) { { delegate: "field" } }

        it "[:field]が返る" do
          expect(generator.send(:delegate_options)).to eq %w[:field]
        end
      end

      context "複数のフィールドを指定された場合" do
        let(:options) { { delegate: "field1,field2,field3" } }

        it "[:field1, :field2, :field3]が返る" do
          expect(generator.send(:delegate_options)).to eq %w[:field1 :field2 :field3]
        end
      end
    end
  end
end
