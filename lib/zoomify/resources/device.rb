module Zoomify
  module Resources
    module Device
      %w(devices devices_create).each do |method|
        define_method method do |*args|
          params = Request.extract_params args
          self.class.send("fire_#{device_without_id_options[method.to_sym]}", "/h323/devices", params)
        end
      end
      %w(device_update device_delete).each do |method|
        define_method method do |*args|
          params = Request.extract_params_and_manage_id_error *args
          self.class.send("fire_#{device_with_id_options[method.to_sym]}", "/h323/devices/#{params[:id]}", params)
        end
      end
      private
        def device_without_id_options
          {devices: 'get', devices_create: 'post'}
        end
        def device_with_id_options
          {device_update: 'patch', device_delete: 'delete'}
        end
    end
  end
end