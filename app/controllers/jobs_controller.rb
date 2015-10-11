class JobsController < ApplicationController
  before_action :authenticate_user!
  
  include ApplicationHelper
  
  def index
    @jobs = current_user.jobs
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(permitted_params)
    @job.user_id = current_user.id
    
    if @job.save
      redirect_to user_jobs_path, notice: 'Your job has been posted.' 
    else
      render :new
    end
  end

  private

  def permitted_params
    params.require(:job).permit(:name, :description, :status, :employment_type)
  end
end
