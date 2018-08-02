module Zoomify
  module Resources
    module Billing
      %w(billing billing_update plan plan_subscribe update_base_plan create_addon update_addon).each do |method|
        define_method method do |*args|
          params = Request.extract_params_and_manage_id_error *args
          method_option = billing_method_options(params)[method.to_sym]
          self.class.send("fire_#{method_option[:request]}", method_option[:url], params)
        end
      end
      private
        def billing_method_options params
          {
              billing: {
                  request: 'get',
                  url: "/accounts/#{params[:id]}/billing"
              },
              billing_update: {
                  request: 'patch',
                  url: "/accounts/#{params[:id]}/billing"
              },
              plan: {
                  request: 'get',
                  url: "/accounts/#{params[:id]}/plans"
              },
              plan_subscribe: {
                  request: 'post',
                  url: "/accounts/#{params[:id]}/plans"
              },
              update_base_plan: {
                  request: 'put',
                  url: "/accounts/#{params[:id]}/plans/base"
              },
              create_addon: {
                  request: 'post',
                  url: "/accounts/#{params[:id]}/plans/addons"
              },
              update_addon: {
                  request: 'put',
                  url: "/accounts/#{params[:id]}/plans/addons"
              }
          }
        end
    end
  end
end