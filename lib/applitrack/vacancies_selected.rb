module Applitrack
  class VacanciesSelected <  ApplitrackObject
    extend ApiActions::List
    extend ApiActions::Retrievable

    class << self

      # API base endpoint for resource
      def endpoint
        "VacanciesSelected()"
      end

      # Acceptable options for #list with translation to API params
      def list_filters
        {
          selection_active: "SelectionActive eq VALUE",
          app_no: "AppNo eq VALUE"
        }
      end

    end


  end
end
