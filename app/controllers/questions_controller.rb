class QuestionsController < ApplicationController
  before_action :check_test_existed, only: %i(new create destroy)
  before_action :list_questions, only: %i(new)
  before_action :search_question, only: %i(destroy)

  def new
    @question = Question.new
    @question.answers.build
  end

  def create
    @question = Question.create question_params

    if @question.save
      @test_question = @test.test_questions.build question: @question
      @test_question.save
      flash[:info] = t ".question_created"
    else
      flash[:danger] = t ".create_question_fail"
    end
    redirect_to new_lesson_question_path @test.lesson
  end

  def destroy
    @question.destroy
    list_questions
    respond_to do |format|
      format.html{redirect_to new_lesson_question_path @test.lesson.id}
      format.js
    end
  end

  private

  def question_params
    params.require(:question).permit :question_id, :content, answers_attributes:
      %i(content is_correct)
  end

  def search_question
    @question = Question.find_by id: params[:id]

    return if @question
    flash[:danger] = t ".question_not_found"
    redirect_to new_lesson_question_path @test.lesson
  end

  def list_questions
    @list_questions = @test.questions.questions_sort
  end

  def build_test
    @test = Test.create lesson_id: params[:lesson_id]

    return if @test.save
    flash.now[:danger] = t ".create_test_fail"
    redirect_to root_path
  end

  def check_test_existed
    @test = Test.find_by lesson_id: params[:lesson_id]
    build_test unless @test

    return if current_user.current_user? @test.lesson.course.trainer
    flash[:danger] = t ".wrong_trainer"
    redirect_to root_path
  end
end
