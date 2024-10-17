class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destory]
  before_action :check_login, only: %i[index show update]
  before_action :check_owner, only: %i[update destory]

  include Pagination

  def index
    @users = User::select(:id, :first_name, :last_name, :email).page(current_page).per(per_page).order(:id)

    options = {
      links: {
      current: api_v1_users_path(page: @users.current_page),
      first: api_v1_users_path(page: 1),
      last: api_v1_users_path(page: @users.total_pages),
      prev: api_v1_users_path(page: @users.prev_page),
      next: api_v1_users_path(page: @users.next_page),
      total_page: @users.total_pages,
      total: @users.count
      }
    }
    render_success_response(data: { users: @users , **options }, message: "success")
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: {
         status: "success", "messaage": "success"
          }, status: :created
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
      :email, :password, :dob, :address, :first_name, :last_name
      )
  end
end
