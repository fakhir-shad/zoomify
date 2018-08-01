module Zoomify
  module Resources
    module Webinar

      %w(webinars webinar_create).each do |method|
        define_method method do |*args|
          params = extract_params_and_raise_id_email_exceptions *args
          self.class.send(user_dependent_method_options[method.to_sym], "/users/#{Request.extract_id_from_params(params)}/webinars", params)
        end
      end

      %w(webinar webinar_update webinar_delete webinar_update_status webinar_panelists webinar_panelists_create webinar_panelists_delete_all webinar_registrants webinar_registrants_create webinar_registrants_update_status past_webinars).each do |method|
        define_method method do |*args|
          params = extract_params_and_raise_id_exception *args
          method_option = method_options(params)[method.to_sym]
          self.class.send("fire_#{method_option[:request]}", method_option[:url], params)
        end
      end

      def webinar_panelists_delete *args
        params = Request.extract_params(args)
        (raise Request.argument_error "Webinar and Panelist Id") if params[:id].blank? && params[:panelist_id].blank?
        self.class.fire_delete("/webinars/#{params[:id]}/panelists/#{params[:panelist_id]}", params)
      end

      private
      def extract_params_and_raise_id_email_exceptions *args
        params = Request.extract_params(args)
        Request.raise_user_id_error(params)
      end

      def extract_params_and_raise_id_exception *args
        params = Request.extract_params(args)
        params[:id].blank? ? (raise Request.argument_error "id") : params
      end

      def method_options params
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
      def user_dependent_method_options
        { webinars: 'fire_get', webinar_create: 'fire_post' }
      end
    end
  end
end