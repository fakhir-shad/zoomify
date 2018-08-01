module Zoomify
  module Resources
    module User
      %w(users user_create).each do |method|
        define_method method do |*args|
          params = Request.extract_params args
          self.class.send(method_without_id_options[method.to_sym], '/users', params)
        end
      end
      %w(user user_update user_delete user_assistants user_assistants_create user_assistants_delete_all user_schedulers user_schedulers_delete_all).each do |method|
        define_method method do |*args|
          params = Request.extract_params args
          (raise Request.argument_error "id") if params[:id].blank?
          method_option = method_with_id_options(params)[method.to_sym]
          self.class.send("fire_#{method_option[:request]}", method_option[:url], params)
        end
      end
      %w(user_assistant_delete user_schedulers_delete).each do |method|
        define_method method do |*args|
          params = Request.extract_params(args)
          method_option = method_with_multiple_id_options(params)[method.to_sym]
          (raise Request.argument_error "User and Assistant Id") if method_option[:condition]
          self.class.fire_delete(method_option[:url], params)
        end
      end

      private
      def method_without_id_options
        {users: 'fire_get', user_create: 'fire_post'}
      end
      def method_with_id_options params
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

        }
      end
      def method_with_multiple_id_options params
        {
            user_assistant_delete: {
                url: "/users/#{params[:id]}/assistants/#{params[:assistant_id]}",
                condition: (params[:id].blank? && params[:assistant_id].blank?)
            },
            user_schedulers_delete: {
                url: "/users/#{params[:id]}/schedulers/#{params[:scheduler_id]}",
                condition: (params[:id].blank? && params[:scheduler_id].blank?)
            }
        }
      end
    end
  end
end