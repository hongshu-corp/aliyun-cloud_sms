require "spec_helper"

RSpec.describe Aliyun::CloudSms::Request::MessageQuery do

  let(:access_key_id) { "aliyun-sms-key-id" }
  let(:access_key_secret) { "aliyun-sms-key-secret" }
  let(:sign_name) { "awesome" }
  let(:client) { Aliyun::CloudSms::Client.new access_key_id, access_key_secret, sign_name }

  let(:mobile) { "13800000000" }
  let(:send_date) { Time.new.strftime("%Y%m%d") }
  let(:biz_id) { "109177619494^4112265203597" }
  let(:page_size)  { 10 }
  let(:current_page)  { 1 }

  let(:sender) { s = described_class.new mobile, send_date, biz_id, page_size, current_page; s.client = client; return s }

  describe "#action" do
    specify { expect(sender.action).to eq "QuerySendDetails" }
  end

  describe "#custom_params" do
    subject { sender.send(:custom_params) }

    specify {
      expect(subject[:PhoneNumber]).to eq mobile
      expect(subject[:SendDate]).to eq send_date
      expect(subject[:BizId]).to eq biz_id
      expect(subject[:PageSize]).to eq page_size
      expect(subject[:CurrentPage]).to eq current_page
    }

    describe "biz_id is nil" do
      let(:biz_id) { nil }
      specify { expect(subject.has_key? :BizId).to be_falsy }
    end
  end
end
