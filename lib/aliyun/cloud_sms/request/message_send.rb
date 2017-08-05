require 'aliyun/cloud_sms/request/base'
require 'rest-client'

module Aliyun
  module CloudSms
    module Request
      class MessageSend < Base

        attr_accessor :mobile, :template_code, :template_param

        def initialize(mobile, template_code, template_param)
          self.mobile = mobile
          self.template_code = template_code
          self.template_param = template_param
        end

        def action
          "SendSms"
        end

        def custom_params
          self.template_param = self.template_param.to_json if self.template_param.is_a?(Hash)

          {
            :PhoneNumbers => self.mobile,
            :TemplateCode => self.template_code,
            :TemplateParam => self.template_param.to_s,
          }
        end

        def send_request
          # params = dynamic_params(self.mobile, self.template_code, self.template_param).merge(intrinsic_params)
          q_without_sig = build_url(get_params)
          q_full= "Signature=#{sign(q_without_sig)}&#{q_without_sig}"

          begin
            response = RestClient.get "#{SERVICE_URL}?#{q_full}"
          rescue RestClient::ExceptionWithResponse => e
            puts e.response
            Rails.logger.error(e.response) if defined? Rails
            e.response
          end
        end

      end
    end
  end
end
