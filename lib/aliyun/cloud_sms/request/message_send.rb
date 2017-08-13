require 'aliyun/cloud_sms/request/base'

module Aliyun
  module CloudSms
    module Request
      class MessageSend < Base

        attr_accessor :mobile, :template_code, :template_param, :optional_params

        def initialize(mobile, template_code, template_param, optional_params = nil)
          self.mobile = mobile
          self.template_code = template_code
          self.template_param = template_param
          self.optional_params = optional_params || {}
        end

        def action
          "SendSms".freeze
        end

        def custom_params
          self.template_param = self.template_param.to_json if self.template_param.is_a?(Hash)

          {
            :PhoneNumbers => self.mobile,
            :TemplateCode => self.template_code,
            :TemplateParam => self.template_param.to_s,
          }.merge!(self.optional_params)
        end
      end
    end
  end
end
