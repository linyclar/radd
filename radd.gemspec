# frozen_string_literal: true

require_relative "lib/radd/version"

Gem::Specification.new do |spec|
  spec.name          = "radd"
  spec.version       = Radd::VERSION
  spec.authors       = ["Linyclar "]
  spec.email         = ["olinyclar@gmail.com"]

  spec.summary       = "要求分析駆動設計（RADD）用のジェネレータ"
  spec.description   = "要求分析駆動設計（RADD）に登場するクラスを生成するGem"
  spec.homepage      = "https://linyclar.github.io/software_development/requirements_analysis_driven_desgin/"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/linyclar/radd"
  spec.metadata["changelog_uri"] = "https://github.com/linyclar/radd/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "rails", ">= 5.1"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
