# Aliyun::CloudSms

基于阿里短信服务接口，支持短信发送与状态查询。

## Installation

在项目的Gemfile里添加下面一行

```ruby
gem 'aliyun-cloud_sms'
```

执行

    $ bundle

或者你也可以

    $ gem install aliyun-cloud_sms

## 构建客户端

### 全局客户端
在config/initializers目录添加一个文件`aliyun-cloud_sms.rb`

``` ruby
Aliyun::CloudSms.configure do |config|
  config.access_key_secret = 'your key secret'
  config.access_key_id = 'your key id'
  config.sign_name = 'your sign name'
end
```

### 多账户支持
有的服务可能会需要给不同的应用发送。
```ruby
client = Aliyun::CloudSms.new('your_access_key_id', 'your_access_key_secret', 'your_sign_name')

client.send_msg('13800000000', 'SMS_80190090', {"customer": "jere"} )
```

## 接口

### 短信发送
如果是全局客户端， 可以使用：
```ruby
Aliyun::CloudSms.send_msg('13800000000', 'SMS_80190090', {"customer": "jere"} )
```

`template_params`可以传字符串，以多账户支持为例：
```ruby
client.send_msg('13800000000', 'SMS_80190090', "{\"customer\":\"jeremy\"}" )
```
### 状态查询
```ruby
client.query_status(mobile, send_date = "#{Time.now.strftime('%Y%m%d')}", biz_id = nil, page_size = 1, current_page = 1)

# e.g.
client.query_status '13800000000'
client.query_status '13800000000', '20170806'
client.query_status '13800000000', '20170806', '109177619494^4112265203597'
client.query_status '13800000000', '20170806', nil, 10
client.query_status '13800000000', '20170806', nil, 10, 2
```
## 贡献

欢迎PR。


## License
[MIT License](http://opensource.org/licenses/MIT).
