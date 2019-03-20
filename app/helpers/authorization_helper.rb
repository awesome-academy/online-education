module AuthorizationHelper
  def current_user
    token = cookies[:token]
    decoded = JsonWebToken.decode token

    if decoded.present?
      user = User.find_by id: decoded[:user_id]
    else
      user = nil
    end
  end

  def login user
    token = JsonWebToken.encode user_id: user.id
    cookies[:token] = token
  end

  def check_login
    redirect_to root_path if logged_in?
  end

  def logged_in?
    current_user.present?
  end
end
