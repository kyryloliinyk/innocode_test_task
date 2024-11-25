# frozen_string_literal: true

module Resources
  module Routes
    class ParseParams
      extend Callable

      def initialize(origin: {}, destination: {})
        @origin = origin
        @destination = destination
      end

      def call
        raise ArgumentError if origin.empty? || destination.empty?

        [parsed_origin, parsed_destination, title]
      end

      private

      attr_reader :origin, :destination

      def parsed_origin
        parsed_waypoint(origin, :origin, :latLng)
      end

      def parsed_destination
        parsed_waypoint(destination, :location, :latLng)
      end

      def title
        "#{parsed_origin}-#{parsed_destination}"
      end

      def parsed_waypoint(hash, *keys)
        parsed_hash = hash.dig(*keys)
        raise ArgumentError unless parsed_hash || parsed_hash.empty?

        "#{parsed_hash[:latitude]}:#{parsed_hash[:longitude]}"
      end
    end
  end
end
