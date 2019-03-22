module AuthorizationHelper
  def current_user
    token = cookies[:token]
    decoded = JsonWebToken.decode token
    decoded.present? ? User.find_by(id: decoded[:user_id]) : nil
  end

  def login user
    token = JsonWebToken.encode user_id: user.id
    cookies[:token] = token
  end

  def check_login
    redirect_to root_path if logged_in?
  end

  def check_user
    redirect_to root_path unless logged_in?
  end

  def logged_in?
    current_user.present?
  end

  def logout
    cookies.delete :token
    @current_user = nil
  end
end
