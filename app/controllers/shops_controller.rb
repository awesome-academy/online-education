class ShopsController < ApplicationController
  before_action :check_course, only: :show

  def index
    @courses = Course.page(params[:page]).per Settings.limit
  end

  def show; end

  private

  def check_course
    @course = Course.find_by id: params[:id]

    return if @course.present?
    flash[:danger] = t ".dont_have_this_course"
    redirect_to shops_path
  end
end
