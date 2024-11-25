# frozen_string_literal: true

module Resources
  module Directions
    class Compute
      extend Callable
      BASE_URL = 'https://routes.googleapis.com/directions/v2'
    
      def initialize(origin:,destination:)
        @origin = origin
        @destination = destination
      end
    
      def call
        return JSON.parse(compute_response.body) if compute_response['status'] == 200
    
        Logger.error("Arror occurred while computing directions." \
          " Status code = #{compute_response['status']}")
      end
    
      private
    
      attr_reader :origin, :destination
    
      def compute_response
        @response ||= connection("#{BASE_URL}::computeRoutes").post do |request|
          request.body = { origin:, destination: }.to_json
        end
      end
    
      def connection
        Faraday.new(
          url: BASE_URL,
          headers: {
            'Content-Type' => 'application/json',
            'X-Google-Api_key' => "#{ENV['GOOGLE_API_KEY']}",
          }
        )
      end
    end
     
  end
end
