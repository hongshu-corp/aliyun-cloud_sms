module Aliyun
  module CloudSms
    module Request
      class MessageQuery < Base
        attr_accessor :mobile, :send_date, :biz_id, :page_size, :current_page

        def initialize(mobile, send_date, biz_id, page_size, current_page)
          self.mobile = mobile
          self.send_date = send_date
          self.biz_id = biz_id
          self.page_size = page_size
          self.current_page = current_page
        end

        def action
          "QuerySendDetails".freeze
        end

        def custom_params
          params = {
            :PhoneNumber => mobile,
            :SendDate => send_date,
            :PageSize => page_size,
            :CurrentPage => current_page
          }

          params.merge!({:BizId => biz_id}) if biz_id

          params
        end
      end
    end
  end
end
