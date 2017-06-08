require 'applitrack/applitrack_object'
require 'applitrack/api_actions/retrievable'
require 'applitrack/api_actions/list'

module Applitrack
  class Application < ApplitrackObject
    extend ApiActions::List
    extend ApiActions::Retrievable

    class << self

      # API base endpoint for resource
      def endpoint
        "Applications()"
      end

      # Acceptable options for #list with translation to API params
      def list_filters
        {
          track_end_date: "TrkEndDate gt VALUE",
          app_no: "AppNo eq VALUE",
          first_name: "AppFirstName eq VALUE",
          last_name: "AppLastName eq VALUE",
          email: "AppEmailAddress eq VALUE"
        }
      end

    end

  end
end
