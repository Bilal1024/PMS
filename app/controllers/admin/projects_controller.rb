# frozen_string_literal: true

class Admin::ProjectsController < Admin::BaseController
  before_action :set_project, only: %i[update show destroy edit]

  def index
    @projects = Project.includes(:client)
  end

  def new
    @project = Project.new
    @attachment = @project.attachments.build
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to admin_projects_path, notice: 'Project was created successfully.'
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to admin_project_path(@project), notice: 'Project was updated successfully.'
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @project.destroy
    redirect_to admin_projects_path, notice: 'Project was deleted successfully.'
  end

  def edit
    @attachment = @project.attachments || @project.attachments.build
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :client_id, attachments_attributes: %i[id avatar _destroy])
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
