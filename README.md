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

You will need an [API key](http://www.freesound.org/api/apply) to use the Freesound gem:

```ruby
require 'freesound'
Freesound.api_key = "your_api_key"
```

And a client object:

```ruby
client = Freesound::Client.new
```

Freesound exposes three resources: 
[sounds](http://www.freesound.org/docs/api/resources.html#sound-resource), 
[users](http://www.freesound.org/docs/api/resources.html#users), and 
[packs](http://www.freesound.org/docs/api/resources.html#packs).
You can request them directly from the client:

```ruby
sound = client.sound(17185)
user  = client.user("alexgenco")
pack  = client.pack(5107)
```

Resources will respond to any attributes returned by the API:

```ruby
sound.bitrate # => 1411
user.username # => "alexgenco"
pack.name     # => "Iceland"
```

You can also search for sounds:

```ruby
client.search("kick") # => (many sounds)
```

The Freesound API supports robust search filters, but this library doesn't
support them quite yet.

More features to come!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

You will need a Freesound.org API key to run the integration tests.
Get one [here](http://www.freesound.org/api/apply) and assign it to the
FREESOUND_KEY environment variable.
