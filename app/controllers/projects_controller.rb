# frozen_string_literal: true

class ProjectsController < ManagerController
  before_action :find_project, only: %i[update show destroy edit]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = 'successfully added project'
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  def edit; end

  private

  def project_params
    params.require(:project).permit(:name, :description, :client_id)
  end

  def find_project
    @project = Project.find(params[:id])
  end
end
