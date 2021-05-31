# Freesound Ruby

Consume the [Freesound.org](http://www.freesound.org) API with Ruby.

_Note_: This repository previously contained the `freesound_ruby` gem. To see the last snapshot of that gem's source, see the [freesound\_ruby-archive](https://github.com/alexgenco/freesound-ruby/pull/new/freesound_ruby-archive) branch.

[![Build Status](https://travis-ci.org/alexgenco/freesound-ruby.png)](https://travis-ci.org/alexgenco/freesound_ruby)
[![Code Climate](https://codeclimate.com/github/alexgenco/freesound-ruby.png)](https://codeclimate.com/github/alexgenco/freesound_ruby)
[![Gem Version](https://badge.fury.io/rb/freesound.png)](http://badge.fury.io/rb/freesound)

## Installation

Add this line to your application's Gemfile:

    gem 'freesound'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install freesound

## Usage

You will need an [API key](http://www.freesound.org/api/apply) to use the Freesound gem:

```ruby
require 'freesound'
Freesound.api_key = "your_api_key"
```

And a client object:

```ruby
client = Freesound::Client.new
```

See the [specs](spec/freesound/client_spec.rb) for usage examples.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

You will need a Freesound.org API key to run the integration tests.
Get one [here](http://www.freesound.org/api/apply) and assign it to the
FREESOUND\_KEY environment variable.
