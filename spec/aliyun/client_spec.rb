require "spec_helper"

RSpec.describe Aliyun::CloudSms::Client do

  let(:access_key_id) { "aliyun-sms-key-id" }
  let(:access_key_secret) { "aliyun-sms-key-secret" }
  let(:sign_name) { "awesome" }
  let(:mobile) { "13800000000" }
  let(:template_code) { "SMS_80190090" }
  let(:template_param) { { :customer => "jeremy" } }

  let(:client) { Aliyun::CloudSms::Client.new access_key_id, access_key_secret, sign_name }

  describe "#intrinsic_params" do
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

  describe "#dynamic_params" do
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

    describe "when param is a string" do
      let(:template_param) { { :customer => "jeremy" }.to_json.to_s }
      specify { expect(subject[:TemplateParam]).to eq template_param }
    end
  end

  describe "#encode" do
    let(:source) { '&' }
    subject { client.send(:encode, source) }
    specify { expect(client.send(:encode, '/')).to eq '%2F' }
    specify { expect(subject).to eq '%26' }
  end

  describe "#build_url" do
    let(:hash) {{  :z => 1, :m => 2, :a => 3, :b => 4} }
    subject { client.send(:build_url, hash) }
    specify { expect(subject).to eq "a=3&b=4&m=2&z=1" }
  end

  describe "#sign" do
    let(:access_key_secret) { "testSecret" }
    let(:str) { "AccessKeyId=testId&Action=SendSms&Format=XML&OutId=123&PhoneNumbers=15300000001&RegionId=cn-hangzhou&SignName=%E9%98%BF%E9%87%8C%E4%BA%91%E7%9F%AD%E4%BF%A1%E6%B5%8B%E8%AF%95%E4%B8%93%E7%94%A8&SignatureMethod=HMAC-SHA1&SignatureNonce=45e25e9b-0a6f-4070-8c85-2956eda1b466&SignatureVersion=1.0&TemplateCode=SMS_71390007&TemplateParam=%7B%22customer%22%3A%22test%22%7D&Timestamp=2017-07-12T02%3A42%3A19Z&Version=2017-05-25" }
    subject { client.send(:sign, str)}
    specify { expect(subject).to eq "zJDF%2BLrzhj%2FThnlvIToysFRq6t4%3D" }
  end
end
