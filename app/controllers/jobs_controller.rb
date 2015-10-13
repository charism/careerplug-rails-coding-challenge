class JobsController < ApplicationController
  before_action :authenticate_user!
  
  include ApplicationHelper
  
  def index
    @user_id = current_user.id
      
    if params[:search] and not params[:search].empty?
      @jobs = Job.search(@user_id, params[:search]).order("created_at DESC")
      @jobs_info_message = "Showing all jobs matching search '#{params[:search]}' (#{@jobs.length})"
    else
      @jobs = current_user.jobs.order("created_at DESC")
      @jobs_info_message = "Showing all jobs (#{@jobs.length})"
    end
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
    respond_to do |format|
      format.js
      format.html {
        @form_submit_url_params  = {:action => "show", :id => @job.id, :user_id => @job.user_id }
      }
    end
  end
  
  def update
    @job = Job.find(params[:id] )
    if @job.update_attributes(job_params)
      respond_to do |format|
        format.js
        format.html {
          redirect_to user_job_path, notice: 'Your job has been successfully updated.'
        }
      end
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
    params.require(:job).permit(:name, :description, :status, :employment_type, :comment)
  end
end
