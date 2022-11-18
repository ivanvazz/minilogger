# Minilogger
Little simple logger for little ruby apps. Supports tagging & buffered output.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add minilogger

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install minilogger

## Usage

```ruby
    Minilogger::MyLogger.new.info('hello world')        #[INFO] hello world
    Minilogger::MyLogger.new.warn('hey, warning!')      #[WARN] hey, warning!
    Minilogger::MyLogger.new.error('oh noo!')           #[ERROR] oh noo!
    Minilogger::MyReverseLogger.new.info('hello world') #[INFO] dlrow olleh

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ivanvazz/minilogger.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
