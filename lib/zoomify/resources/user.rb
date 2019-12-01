module Zoomify
  module Resources
    module User
      %w(users user_create).each do |method|
        define_method method do |*args|
          params = Request.extract_params args
          self.class.send(user_method_without_id_options[method.to_sym], '/users', params)
        end
      end
      %w(user user_update user_delete user_assistants user_assistants_create user_assistants_delete_all user_schedulers user_schedulers_delete_all user_settings user_settings_update user_status_update user_password_update user_permissions user_token user_token_delete).each do |method|
        define_method method do |*args|
          params = Request.extract_params_and_manage_user_id_error *args
          method_option = user_method_with_id_options(params)[method.to_sym]
          self.class.send("fire_#{method_option[:request]}", method_option[:url], params)
        end
      end
      %w(user_assistant_delete user_schedulers_delete).each do |method|
        define_method method do |*args|
          params = Request.extract_params(args)
          method_option = user_method_with_multiple_id_options(params)[method.to_sym]
          (raise Request.argument_error "User and #{method.split('_')[1].singularize.capitalize} Id") if method_option[:condition]
          self.class.fire_delete(method_option[:url], params)
        end
      end

      def upload_picture *args
        params = Request.extract_params_and_manage_user_id_error *args
        (raise Request.argument_error "pic_file") if params[:pic_file].blank?
        self.class.fire_post("/users/#{Request.extract_id_from_params(params)}/picture", params)
      end

      %w(verify_zpk verify_email verify_vanity_name).each do |method|
        define_method method do |*args|
          params = Request.extract_params args
          event = method.split('_').drop(1).join('_')
          (raise Request.argument_error "#{event}") if params[event.to_sym].blank?
          self.class.fire_get("/users/#{event}", params)
        end
      end

      private
        def user_method_without_id_options
          {users: 'fire_get', user_create: 'fire_post'}
        end
        def user_method_with_id_options params
          {
              user: {
                  request: 'get',
                  url: "/users/#{Request.extract_id_from_params(params)}"
              },
              user_update: {
                  request: 'patch',
                  url: "/users/#{Request.extract_id_from_params(params)}"
              },
              user_delete: {
                  request: 'delete',
                  url: "/users/#{Request.extract_id_from_params(params)}"
              },
              user_assistants: {
                  request: 'get',
                  url: "/users/#{Request.extract_id_from_params(params)}/assistants"
              },
              user_assistants_create: {
                  request: 'post',
                  url: "/users/#{Request.extract_id_from_params(params)}/assistants"
              },
              user_assistants_delete_all: {
                  request: 'delete',
                  url: "/users/#{Request.extract_id_from_params(params)}/assistants"
              },
              user_schedulers: {
                  request: 'get',
                  url: "/users/#{Request.extract_id_from_params(params)}/schedulers"
              },
              user_schedulers_delete_all: {
                  request: 'delete',
                  url: "/users/#{Request.extract_id_from_params(params)}/schedulers"
              },
              user_settings: {
                  request: 'get',
                  url: "/users/#{Request.extract_id_from_params(params)}/settings"
              },
              user_settings_update: {
                  request: 'patch',
                  url: "/users/#{Request.extract_id_from_params(params)}/settings"
              },
              user_status_update: {
                  request: 'put',
                  url: "/users/#{Request.extract_id_from_params(params)}/status",
              },
              user_password_update: {
                  request: 'put',
                  url: "/users/#{Request.extract_id_from_params(params)}/password"
              },
              user_permissions: {
                  request: 'get',
                  url: "/users/#{Request.extract_id_from_params(params)}/permissions"
              },
              user_token: {
                  request: 'get',
                  url: "/users/#{Request.extract_id_from_params(params)}/token"
              },
              user_token_delete: {
                  request: 'delete',
                  url: "/users/#{Request.extract_id_from_params(params)}/token"
              }

          }
        end
        def user_method_with_multiple_id_options params
          {
              user_assistant_delete: {
                  url: "/users/#{params[:id]}/assistants/#{params[:assistant_id]}",
                  condition: (params[:id].blank? || params[:assistant_id].blank?)
              },
              user_schedulers_delete: {
                  url: "/users/#{params[:id]}/schedulers/#{params[:scheduler_id]}",
                  condition: (params[:id].blank? || params[:scheduler_id].blank?)
              }
          }
        end
    end
  end
end
