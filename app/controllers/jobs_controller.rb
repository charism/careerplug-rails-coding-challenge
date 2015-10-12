class JobsController < ApplicationController
  before_action :authenticate_user!
  
  include ApplicationHelper
  
  def index
    @jobs = current_user.jobs
  end

  def new
    @job = Job.new
    @form_submit_url_params  = {:action => "create", :user_id => params[:user_id] }
  end

  def create
    @job = Job.new(job_params)
    @job.user_id = current_user.id
    
    if @job.save
      redirect_to user_jobs_path, notice: 'Your job has been posted.' 
    else
      render :new
    end
  end
  
  def edit
    @job = Job.find(params[:id] )
    @form_submit_url_params  = {:action => "show", :id => @job.id, :user_id => @job.user_id }
  end
  
  def update
    @job = Job.find(params[:id] )
    if @job.update_attributes(job_params)
      redirect_to user_job_path, notice: 'Your job has been successfully updated.'
    else
      render :edit
    end
  end
  
  def show
    @job = Job.find(params[:id])
  end
  
  def destroy
    Job.find(params[:id]).destroy
    flash[:success] = "Job deleted"
    redirect_to root_path
  end

  private

  def job_params
    params.require(:job).permit(:name, :description, :status, :employment_type)
  end
end
