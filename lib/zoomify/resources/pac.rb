module Zoomify
  module Resources
    module Pac
      def pac_accounts *args
        params = Request.extract_params_and_manage_user_id_error *args
        self.class.fire_get("/users/#{params[:id]}/pac", params)
      end
    end
  end
end