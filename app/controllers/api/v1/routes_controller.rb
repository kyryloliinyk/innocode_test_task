# frozen_string_literal: true

module Api
  module V1
    class RoutesController < ApiController
      def create
        route = Resources::Routes::Create.call(create_params)
        render json: route.to_json, status: :created
      end

      private

      def create_params
        params.require(:route).permit(
          origin: {
            origin: {
              latLng: [:latitude, :longitude],
            }
          destination: {
            location: {
              latLng: [:latitude, :longitude]
                }
              }
          }
        ).to_h.deep_symbolize_keys
      end
    end    
  end
end
