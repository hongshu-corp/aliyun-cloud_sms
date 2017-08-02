require "aliyun/cloud_sms/version"
require 'aliyun/cloud_sms/configure'
require 'aliyun/cloud_sms/client'

module Aliyun
  module CloudSms
    extend Configure

    def self.send_msg(mobile, template_code, template_param)
      default_client.send_msg mobile, template_code, template_param
    end

    def self.client(access_key_id, access_key_secret, sign_name)
      Aliyun::Client.new access_key_id, access_key_secret, sign_name
    end

    def self.default_client
      Aliyun::CloudSms::Client.new Aliyun::CloudSms.access_key_id, Aliyun::CloudSms.access_key_secret, Aliyun::CloudSms.sign_name
    end
  end
end
