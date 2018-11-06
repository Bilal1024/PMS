class ProjectsController < ManagerController
  before_action :get_project, except: [:index, :new, :create]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.manager = current_user

    if @project.save
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

  def show
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  def edit
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :client_id)
  end

  def get_project
    @project = Project.find(params[:id])
  end
end
