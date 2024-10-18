class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destory]
  before_action :check_login, only: %i[index show update]
  before_action :check_owner, only: %i[update destory]

  before_action only: %i[ update show destory index ] do has_permission([ "super_admin" ]) end

  include UserConcern

  def index
    @users = retreve_users
    render_success_response(data: { users: @users }, meta: @users, message: "success")
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render_success_response(data: @user, message: "success")
    else
      render json: @user.errors, status: :unprocessable_entity
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

  def destory
    @user.destory
    head 204
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def check_owner
    head :forbidden unless @user.id == current_user&.id
  end

  def user_params
    params.require(:user).permit(
      :email, :password, :dob, :address, :first_name, :last_name, :gender, :role
      )
  end
end
