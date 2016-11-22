# RichterCatalogue

richter_catalogue allows users to the search through an abridged version of Gerhard Richter's Painting Catalogue either by the painting's subject, the year in which it was conceived, or directly by its name.


detailed explanation of functionality 

Decide wether you want to search by subject, year or name.

type 'subject' to search catalogue by subject 
type 'year' to search catalogue by year
type 'name' to search catalogue by year

Subject 
  You'll be presented with a numbered list of available subjects.
  You may select one either by number or by name  * names written in lowercase yield correct results
  If your selection is invalid you'll be asked to try again
  Once a correct subject has been selected you'll be presented with a number list of paintings that belong to the selected subject. 
  If you want information on all the paintings type 'all'
  If you want information on a specific painting you may select which painting either by number or by name
  If a painting is selected by name and there are multiple paintings with the same name information will be return on all said paintings

Year 
  You'll be presented with a list of available years of which you may select one.
  If your selection is invalid you'll be asked to try again.
  Once a correct year has been selected you'll be presented with a number list of paintings that belong to the selected year.
  If you wish to see information on all the paintings type 'all'. 
  If you want information on a specific painting you may select which painting either by number or by name.
  If a painting is selected by name and there are multiple paintings with the same name information will be return on all said paintings

Name 
  You'll be asked to input a painting's name. 
  If your input is invalid you'll be asked to try again.
  Once a correct painting's name has be inputed you'll be returned information on that painting
  If the provided painting name matches multiple paintings you'll be returned information on all said paintings.

at any point salve for the original menu you can type 'back' to go back to the previous query

at any point you can type 'exit' to exit the gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'richter_catalogue'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install richter_catalogue

## Usage

following installation run:

    $ richter-catalogue

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/richter_catalogue. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

