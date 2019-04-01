class JwtController < ApplicationController
  before_action :check_login, only: :new

  def new; end

  def create
    user = User.find_by email: login_params[:email].downcase
    remember_me = login_params[:remember_me]

    if user && user.authenticate(login_params[:password])
      login user, remember_me
      flash[:success] = t ".login_success"
      redirect_to user
    else
      flash.now[:danger] = t ".login_fail"
      render :new
    end
  end

  private

  def login_params
    params.require(:login).permit :email, :password, :remember_me
  end
end
