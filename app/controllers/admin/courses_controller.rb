class Admin::CoursesController < ApplicationController
  before_action :check_admin
  before_action :list_courses, only: %i(index)
  before_action :data_list, only: %i(new)
  before_action :search_course, only: %i(show update destroy)
  before_action :list_candidates, only: %i(show)
  before_action :assign_user_as_trainer, only: %i(update)

  def index; end

  def new
    @course = Course.new
  end

  def create
    @course = Course.create course_params

    if @course.save
      tagging
      flash[:success] = t ".course_created"
      redirect_to admin_courses_path
    else
      flash.now[:danger] = t ".create_course_fail"
      data_list
      render :new
    end
  end

  def show; end

  def update
    if @course.update trainer: @user, course_status: :building
      flash[:success] = t ".assign_trainer_success"
      redirect_to admin_courses_path
    else
      flash[:danger] = t ".assign_trainer_failed"
      redirect_to admin_course_path @course
    end
  end

  def destroy
    @course.destroy
    list_courses
    respond_to do |format|
      format.html{redirect_to admin_courses_path}
      format.js
    end
  end

  private

  def course_params
    params.require(:course).permit :name, :course_status, :user_id, :price,
      :overview_video_url, :duration, :description, :employment_conditions
  end

  def data_list
    @list_status = Course.course_statuses
                         .map{|h, _| [I18n.t(Settings.course_i18n_path + h), h]}
    @list_trainer = User.trainer_list
                        .map{|p| [(p.first_name + " " + p.last_name), p.id]}
  end

  def tag_params
    params[:course][:tag]
  end

  def tagging
    tag_params.split(",").each do |tag|
      @tag = Tag.find_by name: tag
      if @tag
        assign_tag_to_course
      else
        @tag = Tag.new name: tag
        if @tag.save
          assign_tag_to_course
        else
          flash.now[:danger] = t(".create_tag_fail") + @tag.name
        end
      end
    end
  end

  def assign_tag_to_course
    @course_tag = @course.course_tags.build tag: @tag

    return if @course_tag.save
    flash[:danger] = t(".assign_tag_fail") + @tag.name
  end

  def list_courses
    @list_courses = Course.course_in_recruitment
  end

  def list_candidates
    @list_candidates = @course.trainer_candidates.includes :user
  end

  def search_course
    @course = Course.find_by id: params[:id]

    return if @course
    flash[:danger] = t ".course_not_found"
    redirect_to admin_courses_path
  end

  def assign_user_as_trainer
    @user = User.find_by id: params[:user_id]
    @user.trainer!

    return if @user.save
    flash[:danger] = t ".assign_trainer_fail"
    redirect_to admin_course_path @course
  end

  def check_admin
    return if current_user.admin?
    flash[:danger] = t ".not_admin"
    redirect_to root_path
  end
end
