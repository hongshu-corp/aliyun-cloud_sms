require "spec_helper"

RSpec.describe Aliyun::CloudSms::Client do

  let(:access_key_id) { "aliyun-sms-key-id" }
  let(:access_key_secret) { "aliyun-sms-key-secret" }
  let(:sign_name) { "awesome" }
  let(:mobile) { "13800000000" }
  let(:template_code) { "SMS_80190090" }
  let(:template_param) { { :customer => "jeremy" } }

  let(:client) { Aliyun::CloudSms::Client.new access_key_id, access_key_secret, sign_name }


  describe "#send_request" do
    subject { client.send_msg mobile, template_code, template_param }

    let(:stub) { MessageSendStub.new mobile, template_code, template_param }
    before{ allow_any_instance_of(Aliyun::CloudSms::Request::MessageSend).to receive(:new).and_return(stub) }

    describe "message send request" do
      let(:result) { double }
      before { allow(stub).to receive(:send_request).and_return(result)}
      before { allow(RestClient).to receive(:get).and_return(result) }
      specify { expect(subject).to eq result }
    end
  end

  class MessageSendStub < Aliyun::CloudSms::Request::MessageSend
    attr_accessor :client

    def initialize(mobile, template_code, template_param)
    end
  end
end
