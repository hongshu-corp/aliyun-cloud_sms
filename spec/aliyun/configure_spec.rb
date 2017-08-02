require "spec_helper"

RSpec.describe Aliyun::CloudSms do

  describe "configuration" do
    let(:access_key_id) { "testid" }
    it "can change secret id" do
      Aliyun::CloudSms.configure do |config|
        config.access_key_id = access_key_id
      end
      expect(Aliyun::CloudSms.access_key_id).to eq access_key_id
    end
  end
end
