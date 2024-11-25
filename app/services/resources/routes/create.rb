# frozen_string_literal: true

module Resources
  module Routes
    class Create
      extend Callable

      def initialize(route_params)
        @route_params = route_params
      end

      def call
        origin, destination, title = parseParams.call(**route_params)

        route = Route.find_or_create_by!(origin:, destination:, title:)
        existing_direction = store.get(route.id)
        return existing_direction if existing_direction

        computed_direction = Directions::Compute.call(origin:, destination:)

        direction = Directions::Create.call(**computed_direction) if computed_direction

        if direction
          route.set_last_updated
          store.set(route.id, direction.to_json)
        end

        direction
      end

      private

      attr_reader :route_params

      def store
        @store ||= Store.new
      end
  end
end
end
