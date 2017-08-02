module Aliyun::CloudSms
  module Configure
    @@action = "SendSms"
    @@format = "JSON"
    @@region_id = "cn-hangzhou"
    @@signature_method = "HMAC-SHA1"
    @@signature_version = "1.0"
    @@sms_version = "2017-05-25"
    @@access_key_id = ""
    @@access_key_secret = ""
    @@sign_name = ""


    def configure
      yield self if block_given?
    end

    def access_key_id=(id)
      @@access_key_id = id
    end

    def access_key_secret=(secret)
      @@access_key_secret = secret
    end

    def sign_name=(sign_name)
      @@sign_name = sign_name
    end

    def action=(action)
      @@action = action
    end

    def action
      @@action
    end

    def format
      @@format
    end

    def region_id
      @@region_id
    end

    def signature_method
      @@signature_method
    end

    def signature_version
      @@signature_version
    end

    def sms_version
      @@sms_version
    end

    def access_key_id
      @@access_key_id
    end

    def access_key_secret
      @@access_key_secret
    end

    def sign_name
      @@sign_name
    end
  end
end
