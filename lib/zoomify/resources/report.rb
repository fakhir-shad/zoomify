module Zoomify
  module Resources
    module Report
      def daily_report *args
        params = Request.extract_params args
        self.class.fire_get("/report/daily", params)
      end
      %w(users_report telephone_report).each do |method|
        define_method method do |*args|
          params = Request.retrieve_params_and_manage_from_to_error *args
          self.class.fire_get(report_method_without_id_options[method.to_sym], params)
        end
      end
      def meetings_report *args
        params = Request.retrieve_params_and_manage_from_to_error *args
        Request.raise_user_id_email_error params
        self.class.fire_get("/report/users/#{Request.extract_id_from_params(params)}/meetings", params)
      end
      %w(meeting_details_report meeting_participants_report meeting_polls_report webinar_daily_report webinar_participants_report webinar_polls_report webinar_qa_report).each do |method|
        define_method method do |*args|
          params = Request.extract_params_and_manage_id_error *args
          self.class.fire_get(report_method_with_id_options(params)[method.to_sym], params)
        end
      end
      private
        def report_method_without_id_options
          {users_report: "/report/users", telephone_report: "/report/telephone"}
        end
        def report_method_with_id_options params
          {
              meeting_details_report: "/report/meetings/#{params[:id]}",
              meeting_participants_report: "/report/meetings/#{params[:id]}/participants",
              meeting_polls_report: "/report/meetings/#{params[:id]}/polls",
              webinar_daily_report: "/report/webinars/#{params[:id]}",
              webinar_participants_report: "/report/webinars/#{params[:id]}/participants",
              webinar_polls_report: "/report/webinars/#{params[:id]}/polls",
              webinar_qa_report: "/report/webinars/#{params[:id]}/qa",
          }
        end
    end
  end
end