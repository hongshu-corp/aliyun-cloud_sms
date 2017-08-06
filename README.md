# Aliyun::CloudSms

This gem is used for sending sms via aliyun sms service, and querying the message status as well.
[中文文档 Chinese document](https://github.com/jerecui/aliyun-cloud_sms/blob/master/README-CN.md)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aliyun-cloud_sms'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aliyun-cloud_sms

## Construct a client

### Global account
Create file aliyun-cloud_sms.rb to your config/initializers.
``` ruby
Aliyun::CloudSms.configure do |config|
  config.access_key_secret = 'your key secret'
  config.access_key_id = 'your key id'
  config.sign_name = 'your sign name'
end
```
### Multiple account support
If you want to send message with multiple sign name, you can build your own message sender client.
```ruby
client = Aliyun::CloudSms.new('your_access_key_id', 'your_access_key_secret', 'your_sign_name')

## API
### Message send
```ruby
Aliyun::CloudSms.send_msg(mobile, template_code, template_param).
```
e.g.
```ruby
Aliyun::CloudSms.send_msg('13800000000', 'SMS_80190090', {"customer": "jere"} )
```

`template_params` could be a string.
```ruby
client.send_msg('13800000000', 'SMS_80190090', "{\"customer\":\"jeremy\"}" )
```

### Status query

```ruby
client.query_status(mobile, send_date = "#{Time.now.strftime('%Y%m%d')}", biz_id = nil, page_size = 1, current_page = 1)

# e.g.
client.query_status '13800000000'
client.query_status '13800000000', '20170806'
client.query_status '13800000000', '20170806', '109177619494^4112265203597'
client.query_status '13800000000', '20170806', nil, 10
client.query_status '13800000000', '20170806', nil, 10, 2
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Welcome pull request.
Hope help.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

