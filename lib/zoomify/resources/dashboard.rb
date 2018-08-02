module Zoomify
  module Resources
    module Dashboard
      %w(meeting_metrics webinar_metrics crc_metrics im_metrics zoom_rooms_metrics).each do |method|
        define_method method do |*args|
          params = Request.extract_params args
          Request.raise_from_to_error params unless method == 'zoom_rooms_metrics'
          self.class.fire_get(dashboard_method_without_id_options[method.to_sym], params)
        end
      end
      %w(meeting_detail_metrics meeting_participants_metrics meeting_participants_qos_metrics meeting_participants_sharing_metrics webinar_details_metrics webinar_participants_metrics webinar_participants_qos_metrics webinar_participants_sharing_metrics).each do |method|
        define_method method do |*args|
          params = Request.extract_params_and_manage_id_error *args
          self.class.fire_get(dashboard_method_with_id_options(params)[method.to_sym], params)
        end
      end
      def retrieve_zoom_room *args
        params = Request.retrieve_params_and_manage_from_to_error *args
        (raise Request.argument_error "id") if params[:id].blank?
        self.class.fire_get("/metrics/zoomrooms/#{params[:id]}", params)
      end
      %w(particular_meeting_participant_qos_metrics particular_webinar_participant_qos_metrics).each do |method|
        define_method method do |*args|
          params = Request.extract_params args
          (raise Request.argument_error "#{method.split('_')[1].capitalize}'s id and participant_id") if method_option[:id].blank? || params[:participant_id].blank?
          self.class.fire_get(dashboard_method_with_multiple_id_options(params)[method.to_sym], params)
        end
      end

      private
        def dashboard_method_without_id_options
          {
              meeting_metrics: '/metrics/meetings',
              webinar_metrics: '/metrics/webinars',
              crc_metrics: '/metrics/crc',
              im_metrics: '/metrics/im',
              zoom_rooms_metrics: '/metrics/zoomrooms'
          }
        end
        def dashboard_method_with_id_options params
          {
              meeting_detail_metrics: "/metrics/meetings/#{params[:id]}",
              meeting_participants_metrics: "/metrics/meetings/#{params[:id]}/participants",
              meeting_participants_qos_metrics: "/metrics/meetings/#{params[:id]}/participants/qos",
              meeting_participants_sharing_metrics: "/metrics/meetings/#{params[:id]}/participants/sharing",
              webinar_details_metrics: "/metrics/webinars/#{params[:id]}",
              webinar_participants_metrics: "/metrics/webinars/#{params[:id]}/participants",
              webinar_participants_qos_metrics: "/metrics/webinars/#{params[:id]}/participants/qos",
              webinar_participants_sharing_metrics: "/metrics/webinars/#{params[:id]}/participants/sharing"
          }
        end
        def dashboard_method_with_multiple_id_options params
          {
              particular_meeting_participant_qos_metrics: "/metrics/meetings/#{params[:id]}/participants/#{params[:participant_id]}/qos",
              particular_webinar_participant_qos_metrics: "/metrics/webinars/#{params[:id]}/participants/#{params[:participant_id]}/qos"
          }
        end

    end
  end
end