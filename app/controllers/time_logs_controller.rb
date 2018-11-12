# frozen_string_literal: true

class TimeLogsController < ApplicationController
  before_action :set_project
  before_action :set_time_log, only: %i[update destroy]
  before_action :authenticate, only: %i[update destroy]

  def create
    @time_log = @project.time_logs.new(time_log_params)
    @time_log.user = current_user
    @time_log.save
  end

  def update
    @time_log.update(time_log_params)
    respond_with_bip(@time_log)
  end

  def destroy
    flash[:notice] = 'TimeLog was deleted successfully.' if @time_log.destroy

    redirect_to project_path(@project)
  end

  private

  def time_log_params
    params.require(:time_log).permit(:hours)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_time_log
    @time_log = @project.time_logs.find(params[:id])
  end

  def authenticate
    return if current_user&.manager? || @time_log.user_id == current_user.id

    redirect_to root_path, flash: { error: 'Invalid access' }
  end
end
