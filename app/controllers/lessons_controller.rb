class LessonsController < ApplicationController
  before_action :search_course, only: %i(new create)
  before_action :list_lessons, only: %i(new)

  def new
    @lessons = Lesson.new
  end

  def create
    @lesson = @course.lessons.build lesson_params

    if @lesson.save
      flash.now[:info] = t ".lesson_created"
      list_lessons
      respond_to do |format|
        format.html{redirect_to new_course_lesson_path}
        format.js
      end
    else
      flash.now[:danger] = t ".fail"
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit :name, :video_url
  end

  def list_lessons
    @list_lessons = @course.lessons.lessons_sort
  end

  def search_course
    @course = Course.find_by id: params[:course_id]

    return if @course
    flash[:danger] = t "course_not_found"
    redirect_to root_path
  end
end
