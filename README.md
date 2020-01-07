# clippings_pluck

[![Gem Version](https://badge.fury.io/rb/clippings_pluck.svg)](https://badge.fury.io/rb/clippings_pluck)
[![MIT](https://img.shields.io/badge/license-MIT-lightgray)](http://opensource.org/licenses/MIT)

Amazon stores all of your kindle highlights and notes in a txt file called "My Clippings.txt".
Amazon will also let you export those highlights as a CSV file.
ClippingsPluck accepts a string read from one of those files and returns an array of hashes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'clippings_pluck'
```

And then execute:

    $ bundle

## ClippingsPluck::CsvParser Usage

_Note:_ this is the preferred way to interact with ClippingsPluck. The Kindle CSV file is
much more reliable and straightforward to parse than the TXT file.

First, read from the csv file:
```ruby
string = File.open("clippings.csv", "rb").read
```

Then, you can pass that string into ClippingsPluck like this:

```ruby
ClippingsPluck::CsvParser.new.run(string)
```

You'll get back an array of hashes, each of which might look something like this:

```ruby
{
  note: nil,
  quote: '"He was not no machine!" screamed Gloria, fiercely and ungrammatically.',
  author: "Isaac Asimov",
  book_title: "I, Robot (The Robot Series Book 1)",
  page: nil,
  location: "245",
  date: nil
}
```

## ClippingsPluck::TxtParser Usage

Using the TXT file parser is similar:

```ruby
file = File.open("./My\ Clippings.txt", "rb")
contents = file.read
```

Then, you can feed the string to ClippingsPluck like this:

```ruby
ClippingsPluck::TxtParser.new.run(contents)
```

You'll get back an array of hashes, each of which might look something like this:

```ruby
{
  note: nil,
  quote: '"He was not no machine!" screamed Gloria, fiercely and ungrammatically.',
  author: "Isaac Asimov",
  book_title: "I, Robot (The Robot Series Book 1)",
  page: nil,
  location: "245",
  date: "Tuesday, November 22, 2017 6:42:51 PM"
}
```

## FAQ

__Q: How do I get ahold of these highlight files?__

__A:__ Follow the instructions [here](doc/export_kindle_highlights.md).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
