# ClippingsPluck

Kindle stores all of your highlights and notes in a txt file called "My Clippings.txt". ClippingsPluck accepts a string of that file data and creates an array of hashes!

## Installation

This gem is a work-in-progress, but it is useable (it's just not published yet). Add this line to your application's Gemfile:

```ruby
gem 'clippings_pluck', git: "https://github.com/jgplane/clippings-pluck.git", ref: '65499e1'
```

And then execute:

    $ bundle

## Usage

There are many different ways to read a "My Clippings.txt" file. Here's one:

```ruby
file = File.open("./My\ Clippings.txt", "rb")
contents = file.read
```

Then, you can feed the string to ClippingsPluck like this:

```ruby
ClippingsPluck::Plucker.new.run(contents)
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

## Development Plan

- [ ] Move over more testing from private repo where ClippingsPluck was born
- [ ] Check the format of the string and raise error if it won't parse
- [ ] Add more functionality to `Clippings < Array`

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

