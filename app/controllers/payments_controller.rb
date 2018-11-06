class PaymentsController < ManagerController
  before_action :get_project

  def create
    @payment = Payment.new(payment_params)
    @payment.project = @project

    if @payment.save
      redirect_to project_path(@project)
    else
      render("projects/show")
    end
  end

  def destroy
    @payment = @project.payments.find(params[:id])
    @payment.destroy
    redirect_to project_path(@project)
  end

  def update
    @payment = @project.payments.find(params[:id])
    @payment.update(payment_params)
    respond_to do |format|
      format.json { head :ok }
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:amount)
  end

  def get_project
    @project = Project.find(params[:project_id])
  end
end
