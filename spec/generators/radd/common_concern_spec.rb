# frozen_string_literal: true

require "spec_helper"
require "generators/radd/rule/rule_generator"

RSpec.describe Radd::CommonConcern do
  subject(:generator) { Radd::Generators::RuleGenerator.new(["calc"]) }

  # rubocop:disable RSpec/SubjectStub
  describe "#modules" do
    let(:body) do
      <<~BODY
        class Foo
          def initialize
          end
        end
      BODY
    end

    before do
      allow(generator).to receive(:capture).and_return(generator.send(:indent, body))
      allow(generator).to receive(:concat).and_return("")
    end

    context "モジュールの指定がない場合" do
      let(:result) { body }

      it "class定義の文字列が返る" do
        generator.send(:modules, [])
        expect(generator).to have_received(:concat).with(result.chomp)
      end
    end

    context "モジュールの指定が1つある場合" do
      let(:result) do
        <<~BODY
          module ModuleName
            class Foo
              def initialize
              end
            end
          end
        BODY
      end

      it "class定義の文字列が返る" do
        generator.send(:modules, ["ModuleName"])
        expect(generator).to have_received(:concat).with(result.chomp)
      end
    end

    context "モジュールの指定が2つある場合" do
      let(:result) do
        <<~BODY
          module ModuleName
            module ModuleName2
              class Foo
                def initialize
                end
              end
            end
          end
        BODY
      end

      it "class定義の文字列が返る" do
        generator.send(:modules, %w[ModuleName ModuleName2])
        expect(generator).to have_received(:concat).with(result.chomp)
      end
    end
  end
  # rubocop:enable RSpec/SubjectStub

  describe "#to_with_name" do
    %w[calc calc_rule].each do |rule_name|
      context "#{rule_name}が指定された場合" do
        it "calc_ruleが返る" do
          expect(generator.send(:to_with_name, rule_name, "rule")).to eq "calc_rule"
        end
      end
    end
  end
end
