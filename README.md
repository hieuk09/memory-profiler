# Memory::Profiler

This is a simple implementation based o Ruby native profiler to be able to
calculate the number of object generated in each piece of code

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'memory-profiler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install memory-profiler

## Usage

You can take a look at the code in `examples/` folder

```
require 'memory/profiler'

Memory::Profiler.start_profiling

# your code here

Memory::Profiler.end_profiling

Memory::Profiler.print_profiling
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hieuk09/memory-profiler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

