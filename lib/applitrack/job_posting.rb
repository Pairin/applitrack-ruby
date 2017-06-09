module Applitrack
  class JobPosting < ApplitrackObject
    extend ApiActions::List
    extend ApiActions::Retrievable

    class << self

      # API base endpoint for resource
      def endpoint
        "JobPostings()"
      end

      # Acceptable options for #list with translation to API params
      def list_filters
        {
          category: "Category eq VALUE",
          title: "Title eq VALUE"
        }
      end

    end

    def position
      return nil if title.empty?
      @position ||= Position.list(specialty: title)[0]
    end

  end
end
