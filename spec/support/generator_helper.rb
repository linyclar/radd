# frozen_string_literal: true

module GeneratorHelper
  extend ActiveSupport::Concern
  included do
    let(:generated_files) { "" }

    after do
      File.delete(*Array(generated_files)) if generated_files.present?
    end
  end
end
