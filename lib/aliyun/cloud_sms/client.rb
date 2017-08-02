require 'uuid'
require 'json'

module Aliyun::CloudSms
  class Client
    def initialize(access_key_id, access_key_secret, sign_name)
      @access_key_id = access_key_id
      @access_key_secret = access_key_secret
      @sign_name = sign_name
    end

    def send_msg(mobile, template_code, template_param)
    end

    private
      def dynamic_params(mobile, template_code, template_param)
        {
          :PhoneNumbers => mobile,
          :TemplateCode => template_code,
          :TemplateParam => template_param.to_json.to_s,
          :Timestamp => timestamp,
          :SignatureNonce => nonce,
        }
      end

      def intrinsic_params
        {
          :AccessKeyId => @access_key_id,
          :SignName => @sign_name,
          :Action => Aliyun::CloudSms.action,
          :Format => Aliyun::CloudSms.format,
          :RegionId => Aliyun::CloudSms.region_id,
          :SignatureMethod => Aliyun::CloudSms.signature_method,
          :SignatureVersion => Aliyun::CloudSms.signature_version,
          :Version => Aliyun::CloudSms.sms_version
        }
      end

      def timestamp
        Time.now.utc.strftime("%FT%TZ")
      end

      def nonce
        UUID.generate
      end
  end
end
