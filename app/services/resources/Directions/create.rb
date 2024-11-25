# frozen_string_literal: true

module Resources
  module Directions
    class Create
      extend Callable

      def initialize(static_duration:, distance:, duration:)
        @static_duration = static_duration
        @distance = distance
        @duration = duration
      end


      def call
        return Direction.new(**dir_args) if data_valid?

        Logger.error("Error. Distance or Duration is invalid.")
      end

      private

      attr_reader :static_duration, :duration, :distance

      def data_valid?
        Integer(distance).positive? && Integer(duration).positive?
      end

      def speed
        @speed ||= distance / duration
      end

      def dir_args
        {
          static_duration:,
          duration:,
          distance:,
          speed:,
          traffic_state:
        }
      end
    
      def traffic_state
        if speed <= 10
          'jam'
        elsif speed <= 40
          'normal'
        else
          'freeway'
        end
      end
    end
    end
  end
end
