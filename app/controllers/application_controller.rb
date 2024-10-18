class ApplicationController < ActionController::API
   include Authenticable

   include ApiResponseHandler
   include Pagination
end
