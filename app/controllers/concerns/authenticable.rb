module Authenticable
  
  def current_user
    return @current_user if @current_user
    
    header = request.headers['Authorization']&.split(' ')&.last

    return nil if header.nil?
    
    secret_key = ENV['SECRET_KEY']
    puts secret_key
    
    decoded = JWT.decode(header, secret_key, true ,{ algorithim: "HS256"}).first
    HashWithIndifferentAccess.new decoded
   
    @current_user = User.find(decoded[:user_id]) rescue ActiveRecord::RecordNotFound
  end

  protected

  def check_login
    head :forbidden unless self.current_user
  end
end