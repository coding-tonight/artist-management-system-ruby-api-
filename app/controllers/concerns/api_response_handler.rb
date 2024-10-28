module ApiResponseHandler
  extend ActiveSupport::Concern

  def json_response(options = {}, status = 500)
    render json: JsonResponse.new(options), status:
  end

  def render_error_response(error, status = 422, message = "")
    json_response({
      success: false,
      message:,
      errors: error
    }, status)
  end

  def render_internal_server_response(error)
    Rails.logger.error(error)
    json_response({
      success: false,
      message: "Ops something went wrong",
      errors: error }, 500)
  end

  def render_success_response(data: {}, message: "", status: 200, meta: {})
    json_response({
      success: true,
      message:,
      data:,
      meta: meta_attributes(meta)
    }, status)
  end

  def meta_attributes(collection, extra_meta =  {})
     return [] if collection.blank?

     {
       pagination: {
         current_page: collection.current_page,
         next_page: collection.next_page,
         prev_page: collection.prev_page,
         total_pages: collection.total_pages,
         total_count: collection.total_count,
         form: (collection.current_page - 1) * 10
        }.merge(extra_meta)
     }
  end
end
