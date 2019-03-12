class UsersController < ApplicationController
  before_action :check_login, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      login @user
      flash[:success] = t ".sign_up_success"
      redirect_to @user
    else
      flash.now[:danger] = t ".sign_up_fail"
      render :new
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit :first_name, :last_name, :email, :birthday,
      :password, :password_confirmation
  end
end
