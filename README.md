# Radd

要求分析駆動設計用のジェネレータGem。

要求分析駆動設計: https://linyclar.github.io/software_development/requirements_analysis_driven_desgin/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'radd',  github: 'linyclar/radd'
```

And then execute:

    $ bundle


## Usage

以下のジェネレータタスクが追加されるので、`bin/rails g radd:rule accounting/calc`のようにして利用してください。各タスクの詳細については`bin/rails g radd:rule --help`のようにするか、各タスクの`USAGE`ファイル（`lib/generators/radd/**/USAGE`）を参照してください。

```
Radd:
  radd:entity
  radd:event
  radd:rule
  radd:state
  radd:swim_lane
  radd:use_case
  radd:value_object
  radd:view:model
  radd:view:rule
  radd:view:state
  radd:view:value_object

Rspec:
  rspec:radd:entity
  rspec:radd:event
  rspec:radd:rule
  rspec:radd:state
  rspec:radd:swim_lane
  rspec:radd:use_case
  rspec:radd:value_object
  rspec:radd:view:model
  rspec:radd:view:rule
  rspec:radd:view:state
  rspec:radd:view:value_object
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
