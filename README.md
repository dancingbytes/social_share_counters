# SocialShareCounters

Get shared counter statistics

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'social_share_counters'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install social_share_counters

## Usage

```ruby

# Vkontakte
SSC.vk('http://www.gogole.com')

# Facebook
SSC.fb('http://www.gogole.com')

# Odnoklassniki
SSC.ok('http://www.gogole.com')

# Pinterest
SSC.pinterest('http://www.gogole.com')

# LinkedIn
SSC.linkedin('http://www.gogole.com')

# Google Plus
SSC.gplus('http://www.gogole.com', 'you_key_api')

# Mail.ru
SSC.mailru('http://www.gogole.com')

# Twitter
SSC.twitter('http://www.gogole.com')

```

## Set some params

### Timeout
SSC.timeout 60 # (30 default)

### For debug
SSC.debug(true)


## License

Author: Tyralion (piliaiev@gmail.com)

Copyright (c) 2015 DansingBytes.ru, released under the BSD license
