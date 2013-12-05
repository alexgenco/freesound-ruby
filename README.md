# Freesound Ruby

Consume the [Freesound.org](http://www.freesound.org) API with Ruby.

[![Build Status](https://travis-ci.org/alexgenco/freesound_ruby.png)](https://travis-ci.org/alexgenco/freesound_ruby)

## Installation

Add this line to your application's Gemfile:

    gem 'freesound_ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install freesound_ruby

## Usage

```ruby
require 'freesound'

# You will need an API key to use the Freesound gem.
# (you can get one at http://www.freesound.org/api/apply)
Freesound.api_key = "your_api_key"

# Instantiate a client:
fs = Freesound::Client.new

# To get a sound by its ID:
sound = fs.sound(125)

# Sounds will respond to any attributes returned by the API:
sound.id         # => 125
sound.bitrate    # => 1411
sound.waveform_l # => "http://www.freesound.org/data/displays/0/125_23_wave_L.png"

# To search for a sound with a query string:
sounds = fs.search("badass")

# To find a user by their username:
me = fs.user("alexgenco")

# Users also have attributes:
me.username # => "alexgenco"

# And sounds:
me.sounds.size # => 10
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
