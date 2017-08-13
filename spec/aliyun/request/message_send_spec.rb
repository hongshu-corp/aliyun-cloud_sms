require "spec_helper"

RSpec.describe Aliyun::CloudSms::Request::MessageSend do

  let(:access_key_id) { "aliyun-sms-key-id" }
  let(:access_key_secret) { "aliyun-sms-key-secret" }
  let(:sign_name) { "awesome" }

  let(:mobile) { "13800000000" }
  let(:template_code) { "SMS_80190090" }
  let(:template_param) { { :customer => "jeremy" } }
  let(:optional_params) { nil }

  let(:client) { Aliyun::CloudSms::Client.new access_key_id, access_key_secret, sign_name }
  let(:sender) { s = Aliyun::CloudSms::Request::MessageSend.new mobile, template_code, template_param, optional_params; s.client = client; return s }

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

    describe "optional_params is ready" do
      let(:optional_params) { { :OutId => 'yourid' } }
      specify { expect(subject[:OutId]).to eq optional_params[:OutId] }

      describe "more keys" do
        let(:optional_params) { { :OutId => 'yourid', :smsUpExtendCode => 'extended code' } }
        specify{
          optional_params.each do |k, v|
            expect(subject[k]).to eq v
          end
        }
      end
    end
  end


  describe "#action" do
    specify { expect(sender.action).to eq "SendSms" }
  end
end
