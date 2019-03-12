class JwtController < ApplicationController
  before_action :check_login, only: :new

  def new; end

  def create
    user = User.find_by email: login_params[:email].downcase

    if user && user.authenticate(login_params[:password])
      login user
      flash[:success] = t ".login_success"
      redirect_to user
    else
      flash.now[:danger] = t ".login_fail"
      render :new
    end
  end

  private

  def login_params
    params.require(:login).permit :email, :password
  end
end
