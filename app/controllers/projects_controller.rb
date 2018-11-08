# frozen_string_literal: true

class ProjectsController < ManagerController
  before_action :set_project, only: %i[update show destroy edit]

  def index
    @projects = Project.includes(:client)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_path, notice: 'Project was created successfully.'
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: 'Project was updated successfully.'
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project was deleted successfully.'
  end

  def edit; end

  private

  def project_params
    params.require(:project).permit(:name, :description, :client_id)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
