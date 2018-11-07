# frozen_string_literal: true

class Admin::TimeLogsController < Admin::BaseController
  before_action :set_project
  before_action :set_time_log, only: %i[update destroy]

  def create
    @time_log = @project.time_logs.new(time_log_params)

    if @time_log.save
      flash[:notice] = 'successfully added TimeLog'
      redirect_to admin_project_path(@project)
    else
      @project.time_logs.delete(@time_log)
      render('admin/projects/show')
    end
  end

  def update
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
    @time_log.destroy
    flash[:notice] = 'successfully deleted time log'
    redirect_to admin_project_path(@project)
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
