module Pagination
   protected

   def current_page
    (params[:page] || 1)
   end

   def per_page
    (params[:per_page] || 10)
   end
end
