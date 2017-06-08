require 'applitrack/version'

require 'applitrack/errors'
require 'applitrack/applitrack_client'

require 'applitrack/util/string_helper'
require 'applitrack/util/response_parser'

require 'applitrack/api_actions/list'
require 'applitrack/api_actions/retrievable'

require 'applitrack/applitrack_object'
require 'applitrack/position'
require 'applitrack/application'
require 'applitrack/job_posting'

module Applitrack
  @api_base = "https://www.applitrack.com/CLIENT_CODE/api/AppliTrackAPI_v3.svc/"

  class << self
    attr_reader :api_base, :client_code
    attr_accessor :username, :password

    def client_code=(new_client_code)
      return if !new_client_code

      previous_client_code = client_code || 'CLIENT_CODE'
      @client_code = new_client_code
      @api_base.gsub!(previous_client_code, new_client_code)
    end

    def client
      @client ||= ApplitrackClient.new
    end

    def config=(opts)
      Applitrack.username = opts[:username]
      Applitrack.password = opts[:password]
      Applitrack.client_code = opts[:client_code]
    end

  end

end
