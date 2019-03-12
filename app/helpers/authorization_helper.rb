module AuthorizationHelper
  def current_user
    token = cookies[:token]
    decoded = JsonWebToken.decode token
    decoded.present? ? User.find_by(id: decoded[:user_id]) : nil
  end

  def login user, remember_me
    token = JsonWebToken.encode user_id: user.id

    if remember_me == Settings.condition
      cookies.permanent[:token] = token
    else
      cookies[:token] = token
    end
  end

  def check_login
    redirect_to root_path if logged_in?
  end

  def check_user
    return if logged_in?
    flash[:danger] = t ".re_login"
    redirect_to root_path
  end

  def logged_in?
    current_user.present?
  end

  def logout
    cookies.delete :token
    @current_user = nil
  end
end
