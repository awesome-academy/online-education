class PurchasedCoursesController < ApplicationController
  before_action :check_user, only: %i(index create destroy)
  before_action :search_request, only: %i(destroy)

  def index
    @pur_courses = current_user.purchased_courses.includes(:course)
                               .page(params[:page]).per Settings.course_per_page
  end

  def create
    redirect_to root_path unless session[:cart]
    transaction
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
    return if @pur_course = PurchasedCourse.find_by(course_id: params[:id])
    flash[:danger] = t ".no_course"
    redirect_back fallback_location: purchased_courses_path
  end

  def transaction
    error_messages = saving_course

    if error_messages.blank?
      flash[:success] = t ".transaction_successful"
    else
      flash[:danger] = t(".transaction_fail") + " " + error_messages
    end
    redirect_to shops_path
  end

  def saving_course
    error_course = ""
    sessions = session[:cart].uniq
    sessions.each do |course|
      pur = current_user.purchased_courses.build course_id: course.to_i      
      error_course += course + ", " unless pur.save
    end
    error_course
  end
end
