class ApplicationController < ActionController::API
   include Authenticable

   include ApiResponseHandler
   # include ApiExceptionHandler
   include Pagination
end
