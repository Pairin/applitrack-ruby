require 'net/http'

module Applitrack
  # ApplitrackClient executes requests and raises errors
  class ApplitrackClient

    # initializes ApplitrackClient
    def initialize
    end

    # verify if config is set and then sends request to passed in url.
    # currently only supports GET requests
    def send_request(url)
      verify_credentials!

      api_response = nil

      complete_url = Applitrack.api_base + url
      uri = URI(complete_url)

      Net::HTTP.start(uri.host, uri.port,
        use_ssl: uri.scheme == 'https') do |http|

        request = Net::HTTP::Get.new(uri.request_uri)
        request.basic_auth(Applitrack.username, Applitrack.password)

        api_response = http.request(request)
        if api_response.code != "200"
          raise api_error(api_response)
        end
      end

      api_response
    end

    # raises errors related to gem config
    def verify_credentials!
      raise AuthenticationError.new("missing client code") if Applitrack.client_code.nil? || Applitrack.client_code.empty?
      raise AuthenticationError.new("missing username") if Applitrack.username.nil? || Applitrack.username.empty?
      raise AuthenticationError.new("missing password") if Applitrack.password.nil? || Applitrack.password.empty?
    end

    # initializes ApiError with response data
    def api_error(response)
      ApiError.new(response.message, response.code)
    end

  end
end
