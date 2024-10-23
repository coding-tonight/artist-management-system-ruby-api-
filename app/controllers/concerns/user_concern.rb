module UserConcern
  extend ActiveSupport::Concern

  include Pagination

  def retreve_users
    @users = User.select(
      :id, :first_name, :last_name, :email, :gender, :role, :address, :dob, :phone
      ).page(current_page).per(per_page).order(:id)
  end

  def reigster_artist(user)
      @name = "#{user.first_name} #{user.last_name}"
      @singer = Singer.new(
        name: @name,
        user: user,
        gender: user.gender,
        dob: user.dob,
        address: user.address
      )
      if @singer.save
      else
        render json: @singer.errors, status: :unprocessable_entity
      end
  end
end
