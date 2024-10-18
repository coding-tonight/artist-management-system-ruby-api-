class Api::V1::TokensController < ApplicationController
  def create
    @user = User.find_by_email(user_params[:email])
    @secret_key = ENV["SECRET_KEY"]

    if @user&.authenticate(user_params[:password])
        render json: {
          token: JWT.encode({ user_id: @user.id, exp: 24.hours.from_now.to_i }, @secret_key),
          email: @user.email
        }
    else
      render json: {
        message: "Invalid Credentials"
      }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
