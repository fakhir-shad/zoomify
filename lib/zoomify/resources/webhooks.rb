module Zoomify
  module Resources
    module Webhooks
      %w(webhook_options webhooks webhooks_create).each do |method|
        define_method method do |*args|
          params = Request.extract_params args
          self.class.send("fire_#{webhook_method_without_id_options[method.to_sym]}", params)
        end
      end
      %w(webhook webhook_update webhook_delete).each do |method|
        define_method method do |*args|
          params = Request.extract_params_and_manage_id_error *args
          self.class.send("fire_#{webhook_method_with_id_options[method.to_sym]}", "/webhooks/#{params[:id]}", params)
        end
      end
      private
        def webhook_method_without_id_options
          {
              webhook_options: {
                request: 'patch',
                url: '/webhooks/options'
              },
              webhooks: {
                  request: 'get',
                  url: '/webhooks'
              },
              webhooks_create: {
                  request: 'post',
                  url: '/webhooks'
              }
          }
        end
        def webhook_method_with_id_options
          {
              webhook: 'get',
              webhook_update: 'patch',
              webhook_delete: 'delete'
          }
        end
    end
  end
end