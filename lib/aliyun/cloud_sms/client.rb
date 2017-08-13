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


    def send_msg(mobile, template_code, template_param, optional_params = {})
      request = Request::MessageSend.new mobile, template_code, template_param, optional_params
      request.client = self

      request.send_request
    end

    def query_status(mobile, send_date = "#{Time.now.strftime('%Y%m%d')}", biz_id = nil, page_size = 1, current_page = 1)
      request = Request::MessageQuery.new mobile, send_date, biz_id, page_size, current_page
      request.client = self

      request.send_request
    end
  end
end
