class CvsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_target_cv, only: %i[new edit update]

  def show
    @cv =  Cv.eager_load(:user, :objectives, :skills, :summaries, :qualifications, :work_experiences).where(user_id: params[:id])
  end

  def new
    if @cv == nil
      @cv = Cv.new(flash[:cv]) 
    else
      redirect_to edit_cv_path
    end
  end

  def create
    cv = Cv.new(cv_params)
    cv.user_id = params[:id]
    if cv.save
      flash[:notice] = "作成しました。"
      redirect_to cv_path
    else
      redirect_to new_cv_path, flash: {
        cv: cv,
        alert: cv.errors.full_messages
      }
    end
  end

  def edit
    if @cv == nil
      redirect_to new_cv_path
    end
    @cv.attributes = flash[:cv] if flash[:cv]
  end

  def update
    if @cv.update(cv_params)
      flash[:notice] = "編集しました。"
      redirect_to cv_path
    else
      redirect_to new_cv_path, flash: {
        cv: @cv,
        alert: @cv.errors.full_messages
      }
    end
  end

  private

  def cv_params
    params.require(:cv).permit(:education, :display, objectives_attributes: [:id, :display, :name, :_destroy], 
      skills_attributes: [:id, :display, :name, :_destroy],
      summaries_attributes: [:id, :display, :name, :_destroy],
      qualifications_attributes: [:id, :display, :name, :_destroy], 
      work_experiences_attributes: [:id, :display, :description, :_destroy])
  end

  def set_target_cv
    user = User.find(params[:id])
    @cv = user.cv
  end
end
