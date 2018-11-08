# frozen_string_literal: true

class Admin::TimeLogsController < Admin::BaseController
  before_action :set_project
  before_action :set_time_log, only: %i[update destroy]

  def create
    @time_log = @project.time_logs.new(time_log_params)

    flash.now[:notice] = 'TimeLog was created successfully.' if @time_log.save
  end

  def update
    @time_log.update(time_log_params)
    respond_with_bip(@time_log)
  end

  def destroy
    @time_log.destroy
    redirect_to admin_project_path(@project), notice: 'TimeLog was deleted successfully'
  end

  private

  def time_log_params
    params.require(:time_log).permit(:hours, :user_id)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_time_log
    @time_log = @project.time_logs.find(params[:id])
  end
end
