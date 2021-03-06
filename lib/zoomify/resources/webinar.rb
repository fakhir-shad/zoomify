module Zoomify
  module Resources
    module Webinar

      %w(webinars webinar_create).each do |method|
        define_method method do |*args|
          params = webinar_extract_params_and_raise_id_email_exceptions *args
          self.class.send(webinar_user_dependent_method_options[method.to_sym], "/users/#{Request.extract_id_from_params(params)}/webinars", params)
        end
      end

      %w(webinar webinar_update webinar_delete webinar_update_status webinar_panelists webinar_panelists_create webinar_panelists_delete_all webinar_registrants webinar_registrants_create webinar_registrants_update_status past_webinars).each do |method|
        define_method method do |*args|
          params = Request.extract_params_and_manage_id_error *args
          method_option = webinar_method_options(params)[method.to_sym]
          self.class.send("fire_#{method_option[:request]}", method_option[:url], params)
        end
      end

      def webinar_panelists_delete *args
        params = Request.extract_params(args)
        (raise Request.argument_error "Webinar and Panelist Id") if params[:id].blank? && params[:panelist_id].blank?
        self.class.fire_delete("/webinars/#{params[:id]}/panelists/#{params[:panelist_id]}", params)
      end

      private
        def webinar_extract_params_and_raise_id_email_exceptions *args
          params = Request.extract_params(args)
          Request.raise_user_id_email_error(params)
          params
        end

        def webinar_method_options params
          {
              webinar: {
                  request: 'get',
                  url: "/webinars/#{params[:id]}"
              },
              webinar_update: {
                  request: 'patch',
                  url: "/webinars/#{params[:id]}"
              },
              webinar_delete: {
                  request: 'delete',
                  url: "/webinars/#{params[:id]}"
              },
              webinar_update_status: {
                  request: 'put',
                  url: "/webinars/#{params[:id]}/status"
              },
              webinar_panelists: {
                  request: 'get',
                  url: "/webinars/#{params[:id]}/panelists"
              },
              webinar_panelists_create: {
                  request: 'post',
                  url: "/webinars/#{params[:id]}/panelists"
              },
              webinar_panelists_delete_all: {
                  request: 'delete',
                  url: "/webinars/#{params[:id]}/panelists"
              },
              webinar_registrants: {
                  request: 'get',
                  url: "/webinars/#{params[:id]}/registrants"
              },
              webinar_registrants_create: {
                  request: 'post',
                  url: "/webinars/#{params[:id]}/registrants"
              },
              webinar_registrants_update_status: {
                  request: 'put',
                  url: "/webinars/#{params[:id]}/registrants/status"
              },
              past_webinars: {
                  request: 'get',
                  url: "past_webinars/#{params[:id]}/instances"
              }
          }
        end
        def webinar_user_dependent_method_options
          { webinars: 'fire_get', webinar_create: 'fire_post' }
        end
    end
  end
end