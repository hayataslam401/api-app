module JsonResponse
  extend ActiveSupport::Concern

  def unprocessable_entity_response(record)
    render json: { errors: record.errors.full_messages }, status: :unprocessable_entity
  end
end