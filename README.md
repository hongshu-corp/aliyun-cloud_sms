# Aliyun::CloudSms

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/aliyun/cloud_sms`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aliyun-cloud_sms'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aliyun-cloud_sms

## Usage

### Global message client
Create file aliyun-cloud_sms.rb to your config/initializers.
``` ruby
Aliyun::CloudSms.configure do |config|
  config.access_key_secret = 'your key secret'
  config.access_key_id = 'your key id'
  config.sign_name = 'your sign name'
end

```
If you want to send message, Aliyun::CloudSms.send_msg(mobile, template_code, template_param).
e.g.
```ruby
Aliyun::CloudSms.send_msg('13800000000', 'SMS_80190090', {"customer": "jere"} )
```
The param is not a string, is a hash instead.

### Multiple account support
If you want to send message with multiple sign name, you can build your own message sender client.
```ruby
client = Aliyun::CloudSms.new('your_access_key_id', 'your_access_key_secret', 'your_sign_name')

client.send_msg('13800000000', 'SMS_80190090', {"customer": "jere"} )
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/aliyun-cloud_sms. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

