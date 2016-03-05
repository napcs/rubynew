# Rubynew

A simple command-line utility for creating new projects in Ruby. Creates a `bin` folder and stub, a `lib` folder with a module
and a `version.rb` file, and a `test` folder with a default test. It also creates a Rakefile set up to run tests with Minitest.

## Installation

As this is a command-line tool, install globally with

```
$ gem install rubynew
```

## Usage

Run the `rubynew` command and pass it the name of the project you want to create. The project
name will be converted to a constant for use as a module name and a class name, similar to how
Bundler works when creating a gem.

```
$ rubynew tip_calculator
```

It creates the following structure:

```
tip_calculator/
├── Rakefile
├── bin
│   └── tip_calculator
├── lib
│   ├── tip_calculator
│   │   └── version.rb
│   └── tip_calculator.rb
└── test
    └── tip_calculator_test.rb
```

If you don't need the `bin` folder, simply delete it.

## Contributing

Please contribute. I'm interested in discussing features, such as providing options for alternative frameworks for testing. However, the default will always be what Ruby's default is. I want this to be simple for beginners, so the defaults will do whatever Ruby does by default. Right now that's Rake and Minitest.

To contribute:

1. Fork it ( https://github.com/napcs/rubynew/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

MIT. See LICENSE.txt.

## History

2016-03-05

* Added `bin` folder and default bin file.
* 1.0.0 version

2015-08-23

* Initial version

