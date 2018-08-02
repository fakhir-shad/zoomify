module Zoomify
  module Resources
    module Tsp
      def dial_in_numbers *args
        params = Request.extract_params args
        self.class.fire_get("/tsp", params)
      end
      %w(tsp_accounts tsp_accounts_create).each do |method|
        define_method method do |*args|
          params = Request.extract_params_and_manage_user_id_error *args
          self.class.send("fire_#{tsp_method_with_id_options[method.to_sym]}", "/users/#{Request.extract_id_from_params(params)}/tsp", params)
        end
      end
      %w(user_tsp_account user_tsp_account_update user_tsp_account_delete).each do |method|
        define_method method do |*args|
          params = Request.extract_params_and_manage_user_id_error *args
          (raise Request.argument_error "tsp_id") if params[:tsp_id].blank?
          self.class.send("fire_#{tsp_method_with_multiple_ids[method.to_sym]}", "/users/#{Request.extract_id_from_params(params)}/tsp/#{params[:tsp_id]}", params)
        end
      end
      private
        def tsp_method_with_id_options
          {tsp_accounts: 'get', tsp_accounts_create: 'post'}
        end
        def tsp_method_with_multiple_ids
          {
              user_tsp_account: 'get',
              user_tsp_account_update: 'patch',
              user_tsp_account_delete: 'delete'
          }
        end
    end
  end
end