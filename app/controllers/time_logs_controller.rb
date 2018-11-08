# frozen_string_literal: true

class TimeLogsController < ApplicationController
<<<<<<< HEAD
  before_action :find_project
  before_action :find_time_log, only: %i[update destroy]
=======
  before_action :set_project
  before_action :set_time_log, only: %i[update destroy]
  before_action :authenticate, only: %i[update destroy]
>>>>>>> 932fd73... Displayed error messages for validation errors

  def create
    @time_log = @project.time_logs.new(time_log_params)
    @time_log.user = current_user

<<<<<<< HEAD
    if @time_log.save
      flash[:notice] = 'successfully added time_log'
      redirect_to project_path(@project)
    else
      @project.time_logs.delete(@time_log)
      render('projects/show')
    end
  end

  def update
    return unless current_user&.manager? || @time_log.user == current_user

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
    return unless current_user&.manager? || @time_log.user == current_user
=======
    flash.now[:notice] = 'TimeLog was created successfully.' if @time_log.save
  end

  def update
    @time_log.update(time_log_params)
    respond_with_bip(@time_log)
  end

  def destroy
    flash.now[:notice] = 'TimeLog was deleted successfully.' if @time_log.destroy
>>>>>>> 932fd73... Displayed error messages for validation errors

    @time_log.destroy
    redirect_to project_path(@project)
  end

  private

  def time_log_params
    params.require(:time_log).permit(:hours)
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_time_log
    @time_log = @project.time_logs.find(params[:id])
  end

  def authenticate
    return if current_user&.manager? || @time_log.user_id == current_user.id

    redirect_to root_path, error: 'Invalid access'
  end
end
