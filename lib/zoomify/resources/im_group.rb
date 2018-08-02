module Zoomify
  module Resources
    module ImGroup
      %w(im_groups im_groups_create).each do |method|
        define_method method do |*args|
          params = Request.extract_params args
          self.class.send("fire_#{im_method_without_id_options[method.to_sym]}", "/im/groups", params)
        end
      end
      %w(im_group im_group_update im_group_delete  im_group_members im_group_members_create).each do |method|
        define_method method do |*args|
          params = Request.extract_params_and_manage_id_error *args
          method_option = im_method_with_id_options(params)[method.to_sym]
          self.class.send("fire_#{method_option[:request]}", method_option[:url], params)
        end
      end
      def im_group_delete_member *args
        params = Request.extract_params args
        (raise Request.argument_error "Both Group's id and member_id") if params[:id].blank? || params[:member_id].blank?
        self.class.fire_delete("/im/groups/#{params[:id]}/members/#{params[:member_id]}", params)
      end

      private
        def im_method_without_id_options
          {im_groups: 'get', im_groups_create: 'post'}
        end
        def im_method_with_id_options params
          {
              im_group: {
                  request: 'get',
                  url: "/im/groups/#{params[:id]}"
              },
              im_group_update: {
                  request: 'patch',
                  url: "/im/groups/#{params[:id]}"
              },
              im_group_delete: {
                  request: 'delete',
                  url: "/im/groups/#{params[:id]}"
              },
              im_group_members: {
                  request: 'get',
                  url: "/im/groups/#{params[:id]}/members"
              },
              im_group_members_create: {
                  request: 'post',
                  url: "/im/groups/#{params[:id]}/members"
              }
          }
        end
    end
  end
end