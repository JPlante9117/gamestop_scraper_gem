# GamestopScraper

Welcome to the GameStop Scraper! This gem will allow you to scrape the listed newly released video games as well as those releasing soon. Each game gets scraped from the home page and instantiated as an accessible object. You can pull information about each of the games, such as price, ESRB rating, and more!

For run instructions, look in the Usage section.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gamestop_scraper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gamestop_scraper

## Usage

There are several other gems required for 'gamestop_scaper' to work, so make sure to run ```bundle install``` prior prior to use.

In order to run this program, run 'ruby bin/releases' in your command line.

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JPlante9117/gamestop_scraper_gem. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the GamestopScraper project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/JPlante9117/gamestop_scraper_gem/blob/master/CODE_OF_CONDUCT.md).

## License

MIT License

Copyright (c) 2019 Jacques Plante

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.