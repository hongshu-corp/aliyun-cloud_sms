require 'aliyun/cloud_sms/request/message_send'
require 'aliyun/cloud_sms/request/message_query'

module Aliyun::CloudSms
  class Client
    attr_accessor :access_key_id, :access_key_secret, :sign_name

    def initialize(access_key_id, access_key_secret, sign_name)
      self.access_key_id = access_key_id
      self.access_key_secret = access_key_secret
      self.sign_name = sign_name
    end


    def send_msg(mobile, template_code, template_param)
      request = Request::MessageSend.new mobile, template_code, template_param
      request.client = self

      request.send_request
    end
  end
end
