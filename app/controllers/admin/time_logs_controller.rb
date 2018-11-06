class Admin::TimeLogsController < Admin::BaseController
  before_action :get_project
  before_action :get_time_log, only: [:update, :destroy]

  def create
    @time_log = TimeLog.new(time_log_params)
    @time_log.project = @project

    if @time_log.save
      redirect_to admin_project_path(@project)
    else
      render("projects/show")
    end
  end

  def update
    @time_log.update(time_log_params)
    respond_to do |format|
      format.json { head :ok }
    end
  end

  def destroy
    @time_log.destroy
    redirect_to admin_project_path(@project)
  end

  private

  def time_log_params
    params.require(:time_log).permit(:hours, :user_id)
  end

  def get_project
    @project = Project.find(params[:project_id])
  end

  def get_time_log
    @time_log = @project.time_logs.find(params[:id])
  end
end
