class TestResultsController < ApplicationController
  before_action :check_empty_submit

  def create
    questions = marking
    flash[:success] = t(".your_score")+": #{questions}/#{total_questions.count}"
    redirect_to lesson_path params[:id]
  end

  private

  def marking
    total_questions
    score = 0
    @questions.each do |question|
      score += 1 if check_answers_per question
    end
    score
  end

  def check_answers_per question
    count = 0
    question.answers.each do |answer|
      break unless params[:answer_ids].include? answer.id.to_s
      answer.is_correct? ? count += 1 : count -= 1
    end
    count == question.answers.correct.count
  end

  def total_questions
    @questions = Test.find_by(lesson_id: params[:id])
                     .questions.includes :answers
  end

  def check_empty_submit
    return if params[:answer_ids]
    flash[:danger] = t(".your_score") + ": 0/#{total_questions.count}"
    redirect_to lesson_path params[:id]
  end
end
