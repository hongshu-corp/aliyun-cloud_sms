require "spec_helper"

RSpec.describe Aliyun::CloudSms::Client do

  let(:access_key_id) { "aliyun-sms-key-id" }
  let(:access_key_secret) { "aliyun-sms-key-secret" }
  let(:sign_name) { "awesome" }
  let(:mobile) { "13800000000" }
  let(:template_code) { "SMS_80190090" }
  let(:template_param) { { :customer => "jeremy" } }

  let(:client) { Aliyun::CloudSms::Client.new access_key_id, access_key_secret, sign_name }

  describe "intrinsic_params" do
    subject { client.send(:intrinsic_params) }

    specify {
      expect(subject[:AccessKeyId]).to eq access_key_id
      expect(subject[:SignName]).to eq sign_name
      expect(subject[:Action]).to eq Aliyun::CloudSms.action
      expect(subject[:SignatureMethod]).to eq Aliyun::CloudSms.signature_method
      expect(subject[:SignatureVersion]).to eq Aliyun::CloudSms.signature_version
      expect(subject[:Version]).to eq Aliyun::CloudSms.sms_version
      expect(subject[:RegionId]).to eq Aliyun::CloudSms.region_id
    }
  end

  describe "dynamic_params" do
    let(:nonce) { "9c398d50-597a-0135-5549-00e650120496" }
    let(:timestamp) { "2017-08-02T06:33:31Z"}

    subject { client.send(:dynamic_params, mobile, template_code, template_param) }

    before {
      allow(client).to receive(:timestamp).and_return(timestamp)
      allow(UUID).to receive(:generate).and_return(nonce)
    }

    specify {
      expect(subject[:PhoneNumbers]).to eq mobile
      expect(subject[:TemplateCode]).to eq template_code
      expect(subject[:TemplateParam]).to eq template_param.to_json.to_s
      expect(subject[:Timestamp]).to eq timestamp
      expect(subject[:SignatureNonce]).to eq nonce
    }
  end
end
