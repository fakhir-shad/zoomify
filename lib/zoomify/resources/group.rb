module Zoomify
  module Resources
    module Group
      %w(groups groups_create).each do |method|
        define_method method do |*args|
          params = Request.extract_params args
          self.class.send("fire_#{group_method_without_id_options[method.to_sym]}", "/groups", params)
        end
      end
      %w(group group_update group_delete group_members group_members_create).each do |method|
        define_method method do |*args|
          params = Request.extract_params_and_manage_id_error *args
          method_option = group_method_with_id_options(params)[method.to_sym]
          self.class.send("fire_#{method_option[:request]}", method_option[:url], params)
        end
      end

      def group_delete_member *args
        params = Request.extract_params args
        (raise Request.argument_error "Both Group's id and member_id") if params[:id].blank? || params[:member_id].blank?
        self.class.fire_delete("/groups/#{params[:id]}/members/#{params[:member_id]}", params)
      end

      private
        def group_method_without_id_options
          {groups: 'get', groups_create: 'post'}
        end
        def group_method_with_id_options params
          {
              group: {
                  request: 'get',
                  url: "/groups/#{params[:id]}"
              },
              group_update: {
                  request: 'patch',
                  url: "/groups/#{params[:id]}"
              },
              group_delete: {
                  request: 'delete',
                  url: "/groups/#{params[:id]}"
              },
              group_members: {
                  request: 'get',
                  url: "/groups/#{params[:id]}/members"
              },
              group_members_create: {
                  request: 'post',
                  url: "/groups/#{params[:id]}/members"
              }
          }
        end
    end
  end
end