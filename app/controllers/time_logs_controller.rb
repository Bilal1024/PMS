# frozen_string_literal: true

class TimeLogsController < ApplicationController
  before_action :set_project
  before_action :set_time_log, only: %i[update destroy]

  def create
    @time_log = @project.time_logs.new(time_log_params)
    @time_log.user = current_user

    flash[:notice] = 'successfully added time_log' if @time_log.save
  end

  def update
    return unless current_user&.manager? || @time_log.user_id == current_user.id

    respond_to do |format|
      if @time_log.update(time_log_params)
        format.html { redirect_to(@time_log, notice: 'TimeLog was successfully updated.') }
      else
        format.html { render action: 'edit' }
      end

      format.json { respond_with_bip(@time_log) }
    end
  end

  def destroy
    return unless current_user&.manager? || @time_log.user_id == current_user.id

    flash[:notice] = 'successfully deleted time log' if @time_log.destroy

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
end
