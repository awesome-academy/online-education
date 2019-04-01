class LessonsController < ApplicationController
  before_action :search_course, only: %i(new create)
  before_action :list_lessons, only: %i(new)
  before_action :current_lesson, only: %i(show)

  def new
    @lessons = Lesson.new
  end

  def create
    @lesson = @course.lessons.build lesson_params

    if @lesson.save
      list_lessons
      respond_to do |format|
        format.html{redirect_to new_course_lesson_path @course}
        format.js
      end
    else
      flash.now[:danger] = t ".create_lesson_fail"
    end
  end

  def show
    @questions = @lesson.test.questions.includes :answers
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

    if @course
      return if current_user.current_user? @course.trainer
      flash[:danger] = t ".wrong_trainer"
    else
      flash[:danger] = t ".course_not_found"
    end
    redirect_to root_path
  end

  def current_lesson
    return if @lesson = Lesson.find_by(id: params[:id])
    flash[:danger] = t ".lesson_doesnt_exist"
    redirect_to root_path
  end
end
