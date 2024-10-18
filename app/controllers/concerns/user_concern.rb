module UserConcern
  extend ActiveSupport::Concern

  include Pagination

  def retreve_users
    @users = User.select(
      :id, :first_name, :last_name, :email, :gender).page(current_page).per(per_page).order(:id)
  end
end
