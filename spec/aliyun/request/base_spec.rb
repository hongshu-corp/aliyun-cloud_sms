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

  describe "#intrinsic_params" do
    let(:nonce) { "9c398d50-597a-0135-5549-00e650120496" }
    let(:timestamp) { "2017-08-02T06:33:31Z"}
    let(:action) { "interesiting action" }

    subject { sender.send(:intrinsic_params) }

    before {
      allow(sender).to receive(:timestamp).and_return(timestamp)
      allow(UUID).to receive(:generate).and_return(nonce)
      allow(sender).to receive(:action).and_return(action)
    }

    specify {
      expect(subject[:AccessKeyId]).to eq access_key_id
      expect(subject[:SignName]).to eq sign_name
      expect(subject[:Action]).to eq action
      expect(subject[:SignatureMethod]).to eq Aliyun::CloudSms.signature_method
      expect(subject[:SignatureVersion]).to eq Aliyun::CloudSms.signature_version
      expect(subject[:Version]).to eq Aliyun::CloudSms.sms_version
      expect(subject[:RegionId]).to eq Aliyun::CloudSms.region_id
      expect(subject[:Timestamp]).to eq timestamp
      expect(subject[:SignatureNonce]).to eq nonce
    }
  end

  describe "#encode" do
    let(:source) { '&' }
    subject { sender.send(:encode, source) }
    specify { expect(sender.send(:encode, '/')).to eq '%2F' }
    specify { expect(subject).to eq '%26' }

    describe "blank char url-encoding" do
      let(:source) { ' ' }
      # If you use CGI.escape, you would get `+`...
      specify { expect(subject).to eq '%20' }
    end
  end

  describe "#build_url" do
    let(:hash) {{  :z => 1, :m => 2, :a => 3, :b => 4} }
    subject { sender.send(:build_url, hash) }
    specify { expect(subject).to eq "a=3&b=4&m=2&z=1" }
  end

  describe "#sign" do
    let(:access_key_secret) { "testSecret" }
    let(:str) { "AccessKeyId=testId&Action=SendSms&Format=XML&OutId=123&PhoneNumbers=15300000001&RegionId=cn-hangzhou&SignName=%E9%98%BF%E9%87%8C%E4%BA%91%E7%9F%AD%E4%BF%A1%E6%B5%8B%E8%AF%95%E4%B8%93%E7%94%A8&SignatureMethod=HMAC-SHA1&SignatureNonce=45e25e9b-0a6f-4070-8c85-2956eda1b466&SignatureVersion=1.0&TemplateCode=SMS_71390007&TemplateParam=%7B%22customer%22%3A%22test%22%7D&Timestamp=2017-07-12T02%3A42%3A19Z&Version=2017-05-25" }
    subject { sender.send(:sign, str)}
    specify { expect(subject).to eq "zJDF%2BLrzhj%2FThnlvIToysFRq6t4%3D" }
  end
end
