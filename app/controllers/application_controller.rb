class ApplicationController < ActionController::API
   include Authenticable
   include ApiResponseHandler
end
