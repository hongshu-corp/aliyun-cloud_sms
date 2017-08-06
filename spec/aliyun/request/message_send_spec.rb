require "spec_helper"

RSpec.describe Aliyun::CloudSms::Request::MessageSend do

  let(:access_key_id) { "aliyun-sms-key-id" }
  let(:access_key_secret) { "aliyun-sms-key-secret" }
  let(:sign_name) { "awesome" }

  let(:mobile) { "13800000000" }
  let(:template_code) { "SMS_80190090" }
  let(:template_param) { { :customer => "jeremy" } }

  let(:client) { Aliyun::CloudSms::Client.new access_key_id, access_key_secret, sign_name }
  let(:sender) { s = Aliyun::CloudSms::Request::MessageSend.new mobile, template_code, template_param; s.client = client; return s }

  describe "#custom_params" do
    subject { sender.send(:custom_params) }

    specify {
      expect(subject[:PhoneNumbers]).to eq mobile
      expect(subject[:TemplateCode]).to eq template_code
      expect(subject[:TemplateParam]).to eq template_param.to_json.to_s
    }

    describe "when param is a string" do
      let(:template_param) { { :customer => "jeremy" }.to_json.to_s }
      specify { expect(subject[:TemplateParam]).to eq template_param }
    end
  end

  describe "#action" do
    specify { expect(sender.action).to eq "SendSms" }
  end
end
