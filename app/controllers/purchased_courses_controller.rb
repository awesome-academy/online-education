class PurchasedCoursesController < ApplicationController
  before_action :check_user, only: %i(index destroy)
  before_action :search_request, only: %i(destroy)

  def index
    @pur_courses = current_user.purchased_courses.includes(:course)
                               .page(params[:page]).per Settings.course_per_page
  end

  def destroy
    if @pur_course.destroy
      flash[:success] = t ".destroy_sucess"
    else
      flash[:danger] = t ".destroy_fail"
    end
    redirect_to purchased_courses_path
  end

  private

  def search_request
    return if @pur_course = PurchasedCourse.find_by(id: params[:id])
    flash[:danger] = t ".no_course"
    redirect_back fallback_location: purchased_courses_path
  end
end
