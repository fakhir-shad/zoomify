require "zoomify/version"
require 'zoomify/request'
require 'zoomify/resources/user'
require 'zoomify/resources/webinar'
require 'zoomify/resources/cloud_recording'
require 'zoomify/client'
require 'zoomify/error'

module Zoomify
  class << self
    attr_accessor :api_key, :api_secret
  end
end
