class TrainerCandidatesController < ApplicationController
  before_action :check_user, only: %i(new)
  before_action :search_course, only: %i(new create)
  before_action :list_courses, only: %i(index)

  def index; end

  def new
    @trainer_candidate = TrainerCandidate.new
  end

  def create
    @trainer_candidate = @course.trainer_candidates
                                .new trainer_candidate_params.merge user_id:
                                  current_user.id

    if @trainer_candidate.save
      flash[:info] = t ".apply_successful"
      redirect_to recruitment_path
    else
      render :new
    end
  end

  private

  def trainer_candidate_params
    params.require(:trainer_candidate).permit :introduce, :cv_url, :user_id
  end

  def list_courses
    @courses = Course.course_in_recruitment.page(params[:page])
                     .per Settings.page_limit
  end

  def search_course
    @course = Course.find_by id: params[:course_id]

    return if @course
    flash[:danger] = t ".course_not_found"
    redirect_to root_path
  end
end
