module Zoomify
  module Resources
    module Meeting
      %w(meetings meetings_create).each do |method|
        define_method method do |*args|
          params = Request.extract_params_and_manage_user_id_error *args
          self.class.send("fire_#{meeting_method_with_user_id_options[method.to_sym]}", "/users/#{Request.extract_id_from_params(params)}/meetings", params)
        end
      end
      %w(meeting meeting_update meeting_delete meeting_update_status meeting_registrants meeting_registrants_create meeting_registrants_update_status).each do |method|
        define_method method do |*args|
          params = Request.extract_params_and_manage_id_error *args
          method_option = meeting_method_with_meeting_id_options(params)[method.to_sym]
          self.class.send("fire_#{method_option[:request]}", method_option[:url], params)
        end
      end
      %w(past_meeting past_meeting_participants).each do |method|
        define_method method do |*args|
          params = Request.extract_params args
          (raise Request.argument_error "uuid") if params[:uuid].blank?
          self.class.fire_get("/past_meetings/#{params[:uuid]}", params)
        end
      end
      private
        def meeting_method_with_user_id_options
          {meetings: 'get', meetings_create: 'post'}
        end
        def meeting_method_with_meeting_id_options params
          {
              meeting: {
                  request: 'get',
                  url: "/meetings/#{params[:id]}"
              },
              meeting_update: {
                  request: 'patch',
                  url: "/meetings/#{params[:id]}"
              },
              meeting_delete: {
                  request: 'delete',
                  url: "/meetings/#{params[:id]}"
              },
              meeting_update_status: {
                  request: 'put',
                  url: "/meetings/#{params[:id]}/status"
              },
              meeting_registrants: {
                  request: 'get',
                  url: "/meetings/#{params[:id]}/registrants"
              },
              meeting_registrants_create: {
                  request: 'post',
                  url: "/meetings/#{params[:id]}/registrants"
              },
              meeting_registrants_update_status: {
                  request: 'put',
                  url: "/meetings/#{params[:id]}/registrants/status"
              }
          }
        end
    end
  end
end