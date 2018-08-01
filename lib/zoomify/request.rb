module Zoomify
  class Request
    class << self
      def extract_params(args)
        args.last.is_a?(::Hash) ? args.pop.with_indifferent_access : {}
      end
      def extract_id_from_params params
        params[:id].blank? ? params[:email] : params[:id]
      end
      def extract_id_vs_uuid_from_params params
        params[:id].blank? ? params[:uuid] : params[:id]
      end
      def argument_error(name)
        name ? ArgumentError.new("#{name} is required!") : ArgumentError.new
      end
      def raise_error(response)
        response["error"] ? raise(Error.new(response["error"]["message"])) : response
      end
      def extract_errors response, method_name, url, args
        Request.raise_error(response)
        case response.code
          when 204
            Request.extract_response_vs_object(response) {
              Request.build_object(204, 'Action Completed Successfully!')
            }
          when 404
            Request.extract_response_vs_object(response){
              Request.build_object(404, 'Content Not Found!')
            }
          when 401
            Zoomify::Client.headers(Request.headers) && eval("Zoomify::Client.#{method_name}(url, args)")
          else
            Request.extract_response_vs_object(response){
              Request.build_object(response.code, 'Invalid Response!')
            }
        end
      end
      def headers
        exp = (Time.now.to_i + (4*3600))
        iss_payload = {
            iss: Zoomify.api_key,
            exp: exp
        }
        token = JWT.encode iss_payload, Zoomify.api_secret, 'HS256'
        {
            'Accept' => 'application/json',
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer #{token}"
        }
      end
      def build_object code, msg
        OpenStruct.new(code: code, message: msg)
      end
      def extract_response_vs_object response
        parsed_response = response.parsed_response
        unless parsed_response.blank?
          hash = response.kind_of?(Hash) ? parsed_response : JSON.parse(parsed_response)
          OpenStruct.new(hash)
        else
          yield
        end
      end
      def raise_user_id_error params
        (raise Request.argument_error "User's id or email") if params[:id].blank? && params[:email].blank?
      end
      def raise_meeting_id_error params
        (raise Request.argument_error "Meeting id or uuid") if params[:id].blank? && params[:uuid].blank?
      end
    end
  end
end