class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show destroy ]
  before_action :check_login, only: %i[ index show update destroy createByAdmin ]
  # before_action :check_owner, only: %i[ update ]

  before_action only: %i[ update show destroy index ] do has_permission([ "super_admin" ]) end

  include UserConcern

  def index
    @users = retreve_users
    render_success_response(data: { users: @users }, meta: @users, message: "success")
  end

  def create
    ActiveRecord::Base.transaction do
      begin
        user_params[:role] = user_params[:role].nil? ?  "artist": user_params[:role]

        @user = User.new(**user_params)
        if @user.save
          if @user.role == "artist"
            reigster_artist(@user)
          end
          render_success_response(message: "User register successfully")
        else
          render json: @user.errors, status: :unprocessable_entity
        end

      rescue => e
        Rails.logger.error "Transaction failed: #{e.message}"
        render_error_response(message: "Ops something went wrong")
      end
    end
  end

  def createByAdmin
    self.create
  end

  def show
   render json: @user
  end

  def update
    @user = User.find(params[:id])

    if @user.nil?
      render_error_response(message: "User does't exists")
    end

    if @user.update(user_params)
      render_success_response(message: "User updated successfully")
    else
      render_error_response(data: @user.errors, message: "Validation Error")
    end
  end

  def destroy
    @user.destroy
    render_success_response(message: "Successfully deleted")
  end


  private
  def set_user
    @user = User.select(
     :id, :email, :first_name, :last_name, :gender, :role, :address, :dob, :phone
    ).find(params[:id])
  end

  def check_owner
    head :forbidden unless @user.id == current_user&.id
  end

  def user_params
    permitted_params = [ :email, :password, :dob, :address, :first_name, :last_name, :gender, :role, :phone ]
    permitted_params << :password if params[:user][:password].present?

    params.require(:user).permit(permitted_params)
  end
end
