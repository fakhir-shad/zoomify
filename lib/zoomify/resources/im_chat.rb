module Zoomify
  module Resources
    module ImChat
      def im_chat_sessions *args
        params = Request.retrieve_params_and_manage_from_to_error *args
        self.class.fire_get("/im/chat/sessions", params)
      end
      def im_chat_session_messages *args
        params = Request.retrieve_params_and_manage_from_to_error *args
        (raise Request.argument_error "Session's id") if params[:id].blank?
        self.class.fire_get("/im/chat/sessions/#{params[:id]}", params)
      end
    end
  end
end