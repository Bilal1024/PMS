# frozen_string_literal: true

class PaymentsController < ManagerController
  before_action :find_project
  before_action :find_payment, only: %i[destroy update]

  def create
    @payment = @project.payments.new(payment_params)

<<<<<<< HEAD
    if @payment.save
      flash[:notice] = 'successfully added payment'
      redirect_to project_path(@project)
    else
      @project.payments.delete(@payment)
      render('projects/show')
    end
=======
    flash.now[:notice] = 'Payment was created successfully.' if @payment.save
>>>>>>> 932fd73... Displayed error messages for validation errors
  end

  def destroy
    @payment.destroy
    redirect_to project_path(@project), notice: 'Payment was deleted successfully.'
  end

  def update
    @payment.update(payment_params)
    respond_with_bip(@payment)
  end

  private

  def payment_params
    params.require(:payment).permit(:amount)
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_payment
    @payment = @project.payments.find(params[:id])
  end
end
