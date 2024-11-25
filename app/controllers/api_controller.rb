# frozen_string_literal: true

class ApiController < ActionController::API
  before_action :validate_google_api_key
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::ArgumentError, with: :bad_request
  rescue_from ActiveRecord::ActiveRecord::RecordInvalid, with: :bad_request

  private

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end

  def bad_request
    render json: { error: 'Invalid arguments in request' }, status: :bad_request
  end

  def validate_google_api_key
    client_key = request.headers['X-Google-Api_key']
    server_key = ENV['GOOGLE_API_KEY']

    return if client_key.present? && client_key == server_key

    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
