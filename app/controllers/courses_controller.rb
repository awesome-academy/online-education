class CoursesController < ApplicationController
  before_action :check_user, :search_course, only: %i(show)

  def show; end

  private

  def search_course
    @course = Course.find_by id: params[:id]

    return search_lessons if @course
    flash[:danger] = t ".course_doesnt_exist_anymore"
    redirect_to purchased_courses_path
  end

  def search_lessons
    @list_lessons = @course.lessons
                           .page(params[:page]).per Settings.lessons_per_page
  end
end
