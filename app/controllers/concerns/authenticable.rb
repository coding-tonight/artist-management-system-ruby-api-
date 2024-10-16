module Authenticable
  def get_token
    header = request.headers["Authorization"]&.split(" ")&.last

    return nil if header.nil?

    secret_key = ENV["SECRET_KEY"]

    decoded = JWT.decode(header, secret_key, true, { algorithim: "HS256" }).first
    HashWithIndifferentAccess.new decoded
  end

  def current_user
    puts @current_user
    return @current_user if @current_user

    decoded = self.get_token

    begin
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound
     head :unauthorized and return
    end
  end

  protected

  def check_login
    head :forbidden unless self.current_user
  end

  def has_permission(roles)
    @current_user = self.current_user
    head :unauthorized unless @current_user && roles.include?(@current_user.role)
  end
end
