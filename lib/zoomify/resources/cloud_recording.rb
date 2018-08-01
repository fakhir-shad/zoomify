module Zoomify
  module Resources
    module CloudRecording
      def user_cloud_recordings *args
        params = Request.extract_params args
        Request.raise_user_id_error(params)
        (raise Request.argument_error "from and to") if (params[:from].blank? || params[:to].blank?)
        self.class.fire_get("/users/#{Request.extract_id_from_params(params)}/recordings", params)
      end
      %w(meeting_cloud_recordings meeting_cloud_recordings_delete_all meeting_cloud_recordings_recover).each do |method|
        define_method method do |*args|
          params = Request.extract_params args
          Request.raise_meeting_id_error params
          method_option = recording_with_meeting_id_options(params)[method.to_sym]
          self.class.send("fire_#{method_option[:request]}", method_option[:url], params)
        end
      end
      %w(meeting_cloud_recording_delete meeting_cloud_recording_recover).each do |method|
        define_method method do |*args|
          params = Request.extract_params args
          (raise Request.argument_error "Meeting id and Recording id") if params[:id].blank? || params[:recording_id].blank?
          method_option = recording_with_multiple_ids(params)[method.to_sym]
          self.class.send("fire_#{method_option[:request]}", method_option[:url], params)
        end
      end
      private
      def recording_with_meeting_id_options params
        {
            meeting_cloud_recordings:
                {
                    request: 'get',
                    url: "/meetings/#{Request.extract_id_vs_uuid_from_params(params)}/recordings"
                },
            meeting_cloud_recordings_delete_all:
                {
                    request: 'delete',
                    url: "/meetings/#{Request.extract_id_vs_uuid_from_params(params)}/recordings"
                },
            meeting_cloud_recordings_recover:
                {
                    request: 'put',
                    url: "/meetings/#{Request.extract_id_vs_uuid_from_params(params)}/recordings/status"
                }
        }
      end

      def recording_with_multiple_ids params
        {
            meeting_cloud_recording_delete:
                {
                    request: 'delete',
                    url: "/meetings/#{Request.extract_id_vs_uuid_from_params(params)}/recordings/#{params[:recording_id]}"
                },
            meeting_cloud_recording_recover:
                {
                    request: 'put',
                    url: "/meetings/#{Request.extract_id_vs_uuid_from_params(params)}/recordings/#{params[:recording_id]}/status"
                }
        }
      end
    end
  end
end