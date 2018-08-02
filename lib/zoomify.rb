require "zoomify/version"
require 'zoomify/request'
require 'zoomify/resources/user'
require 'zoomify/resources/webinar'
require 'zoomify/resources/cloud_recording'
require 'zoomify/resources/account'
require 'zoomify/resources/billing'
require 'zoomify/resources/meeting'
require 'zoomify/resources/group'
require 'zoomify/resources/im_group'
require 'zoomify/resources/im_chat'
require 'zoomify/resources/report'
require 'zoomify/resources/dashboard'
require 'zoomify/resources/webhooks'
require 'zoomify/resources/tsp'
require 'zoomify/resources/pac'
require 'zoomify/resources/device'
require 'zoomify/client'
require 'zoomify/error'

module Zoomify
  class << self
    attr_accessor :api_key, :api_secret
  end
end
