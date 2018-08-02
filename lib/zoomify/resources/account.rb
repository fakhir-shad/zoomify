module Zoomify
  module Resources
    module Account
      %w(accounts accounts_create).each do |method|
        define_method method do |*args|
          params = Request.extract_params args
          self.class.send("fire_#{account_without_id_options[method.to_sym]}", "/accounts", params)
        end
      end

      %w(account accounts_delete accounts_update_options accounts_settings accounts_settings_update).each do |method|
        define_method method do |*args|
          params = Request.extract_params_and_manage_id_error *args
          method_option = account_with_id_options(params)[method.to_sym]
          self.class.send("fire_#{method_option[:request]}", method_option[:url], params)
        end
      end

      private
        def account_without_id_options
          {accounts: 'get', accounts_create: 'post'}
        end
        def account_with_id_options params
          {
            account: {
                request: 'get',
                url: "/accounts/#{params[:id]}"
            },
            accounts_delete: {
                request: 'delete',
                url: "/accounts/#{params[:id]}"
            },
            accounts_update_options: {
                request: 'patch',
                url: "/accounts/#{params[:id]}/options"
            },
            accounts_settings: {
                request: 'get',
                url: "/accounts/#{params[:id]}/settings"
            },
            accounts_settings_update: {
                request: 'patch',
                url: "/accounts/#{params[:id]}/settings"
            }
          }
        end
    end
  end
end