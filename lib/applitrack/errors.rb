module Applitrack
  class ApplitrackError < StandardError

    def initialize(message)
      @message = message
    end

    def to_s
      @message
    end

  end

  # is raised when Applitrack is missing credentials
  class AuthenticationError < ApplitrackError
  end

  # is raised when API returns non-200 response code
  class ApiError < ApplitrackError

    def initialize(message, response_code)
      @message = message
      @response_code = response_code
    end

    def to_s
      "#{@response_code} #{@message}"
    end

  end
end
