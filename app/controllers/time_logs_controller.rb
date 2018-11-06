class TimeLogsController < ApplicationController
  before_action :get_project
  before_action :get_time_log, only: [:update, :destroy]

  def create
    @time_log = TimeLog.new(time_log_params)
    @time_log.project = @project
    @time_log.user = current_user

    if @time_log.save
      redirect_to project_path(@project)
    else
      render("projects/show")
    end
  end

  def update
    if @time_log.user != current_user
      flash[:error] = 'you aren\'t authorized to perform this action'
      respond_to do |format|
        format.json { head :error }
      end
    else
      @time_log.update(time_log_params)
      respond_to do |format|
        format.json { head :ok }
      end
    end
  end

  def destroy
    if @time_log.user != current_user
      flash[:error] = 'you aren\'t authorized to perform this action'
      redirect_to project_path(@project)
    else
      @time_log.destroy
      redirect_to project_path(@project)
    end
  end

  private

  def time_log_params
    params.require(:time_log).permit(:hours)
  end

  def get_project
    @project = Project.find(params[:project_id])
  end

  def get_time_log
    @time_log = @project.time_logs.find(params[:id])
  end
end
