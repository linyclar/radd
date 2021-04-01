# frozen_string_literal: true

# 生成結果の比較マッチャー
RSpec::Matchers.define :generated_eq do |expected|
  match do |actual|
    begin
      FileUtils.cmp(actual, "spec/fixtures/generated_results/#{expected}")
    rescue StandardError
      false
    end
  end
end
