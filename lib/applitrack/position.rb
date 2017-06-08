module Applitrack
  class Position < ApplitrackObject
    extend ApiActions::List
    extend ApiActions::Retrievable

    class << self

      # API base endpoint for resource
      def endpoint
        "Positions()"
      end

      # Acceptable options for #list with translation to API params
      def list_filters
        {
          position_code: "PositionCode eq VALUE",
          specialty: "Specialty eq VALUE",
          id: "ID eq VALUE"
        }
      end

    end

  end
end
