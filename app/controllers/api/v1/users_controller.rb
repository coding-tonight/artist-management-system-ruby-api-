class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  before_action :check_login, only: %i[ index show update destroy ]
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
        @role = "artist" unless user_params[:role]
        @user = User.new(**user_params, role: @role)

        if @user.save
          if @role == "artist"
            reigster_artist(@user)
          end
          render_success_response(message: "User register successfully")
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      rescue => e
        Rails.logger.error "Transaction failed: #{e.message}"
        raise ActiveRecord::Rollback
      end
    end
  end

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
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
    params.require(:user).permit(
      :email, :password, :dob, :address, :first_name, :last_name, :gender, :role, :phone
      )
  end
end
