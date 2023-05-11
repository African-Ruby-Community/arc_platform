# Capistrano::Webpacker::Precompile

This gem add assets precompilation to **webpacker** gem.

## Installation

Add this line to your application's Gemfile development group:

```ruby
gem 'capistrano-webpacker-precompile', require: false
```

And then execute:
```
$ bundle
```

## Usage

To add webpacker precompile task add this line to your **Capfile**:
```ruby
require "capistrano/webpacker/precompile"
```

Then you need do edit your `config/deploy.rb` file and add next line:
```ruby
after 'deploy:updated', 'webpacker:precompile'
```

Done!

Now `cap production deploy` command will automatically precompile webpacker assets and sync it with remote server.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Capistrano::Webpacker::Precompile project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/capistrano-webpacker-precompile/blob/master/CODE_OF_CONDUCT.md).
