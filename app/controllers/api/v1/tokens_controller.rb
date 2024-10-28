class Api::V1::TokensController < ApplicationController
  def create
    begin
        @user = User.find_by_email(user_params[:email])
        @secret_key = ENV["SECRET_KEY"]

        if @user&.authenticate(user_params[:password])

            @artist =  Singer.find_by(user_id: @user.id).id if @user.role == "artist"

            render json: {
              token: JWT.encode({ user_id: @user.id, exp: 24.hours.from_now.to_i }, @secret_key),
              email: @user.email,
              role: @user.role,
              artist_id:  @artist,
              full_name: "#{@user.first_name} #{@user.last_name}"
            }
        else
          render json: {
            message: "Invalid Credentials"
          }, status: :unauthorized
        end

    rescue ActiveModel::Error => e
       Rails.logger.error! e
       render_error_response(message: "Ops something went wrong", status: 500)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
