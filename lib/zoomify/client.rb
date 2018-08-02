require 'httparty'
require 'jwt'

module Zoomify
  class Client

    include HTTParty
    debug_output $stdout
    include Resources::User
    include Resources::Webinar
    include Resources::CloudRecording
    include Resources::Account
    include Resources::Billing
    include Resources::Meeting
    include Resources::Group
    include Resources::ImGroup
    include Resources::ImChat
    include Resources::Report
    include Resources::Dashboard
    include Resources::Webhooks
    include Resources::Tsp
    include Resources::Pac
    include Resources::Device

    base_uri 'https://api.zoom.us/v2/'

    def initialize(*args)
      params = Request.extract_params(args)
      raise Request.argument_error("api_key and api_secret") unless params[:api_key] && params[:api_secret]
      Zoomify.api_key = params[:api_key]
      Zoomify.api_secret = params[:api_secret]
      self.class.headers(Request.headers)
    end


    class << self

      %w(fire_get fire_delete).each do |fire|
        define_method fire do |url, args|
          cater_exception fire, url, args, true
        end
      end

      %w(fire_post fire_patch fire_put).each do |fire|
        define_method fire do |url, args|
          cater_exception fire, url, args, false
        end
      end

      private
        def cater_exception fire, url, args, query
          begin
            args.reject!{ |arg| arg['id'] }
            params = query ? {query: args} : {body: args.to_json}
            response = send(fire.split('_')[1], url, params)
            Request.extract_errors response, fire, url, args
          rescue Net::OpenTimeout, Net::ReadTimeout, Timeout::Error => e
            raise ::Zoomify::TimeoutError.new(e.message)
          end
        end
    end
  end
end