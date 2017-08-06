require "aliyun/cloud_sms/version"
require 'aliyun/cloud_sms/configure'
require 'aliyun/cloud_sms/client'

module Aliyun
  module CloudSms
    extend Configure

    def self.send_msg(mobile, template_code, template_param)
      default_client.send_msg mobile, template_code, template_param
    end

    def self.query_status(mobile, send_date = "#{Time.now.strftime('%Y%m%d')}", biz_id = nil, page_size = 1, current_page = 1)
      default_client.query_status mobile, send_date, biz_id, page_size, current_page
    end

    def self.client(access_key_id, access_key_secret, sign_name)
      Aliyun::Client.new access_key_id, access_key_secret, sign_name
    end

    def self.default_client
      Aliyun::CloudSms::Client.new Aliyun::CloudSms.access_key_id, Aliyun::CloudSms.access_key_secret, Aliyun::CloudSms.sign_name
    end
  end
end
