require 'uuid'
require 'json'
require 'cgi'
require 'openssl'
require 'base64'

module Aliyun::CloudSms
  class Client
    def initialize(access_key_id, access_key_secret, sign_name)
      @access_key_id = access_key_id
      @access_key_secret = access_key_secret
      @sign_name = sign_name
    end

    SERVICE_URL = "http://dysmsapi.aliyuncs.com/"

    def send_msg(mobile, template_code, template_param)
      params = dynamic_params(mobile, template_code, template_param).merge(intrinsic_params)
      q_without_sig = build_url(params)
      q_full= "Signature=#{sign(q_without_sig)}&#{q_without_sig}"

      begin
        response = RestClient.get "#{SERVICE_URL}#{q_full}"
        response.force_encoding("utf-8")
        p response.methods
      rescue => err
        p err
      end
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

      def build_url(hash)
        hash.map{|k,v|"#{encode(k.to_s)}=#{encode(v.to_s)}"}.sort.join('&')
      end

      def encode(str)
        CGI.escape(str)
      end

      def sign(str)
        str = "GET&#{encode('/')}&#{encode(str)}"
        ret = OpenSSL::HMAC.digest('sha1', "#{@access_key_secret}&", str)
        ret = Base64.encode64(ret)
        encode(ret.chomp)
      end
  end
end
