# frozen_string_literal: true

class PaymentsController < ManagerController
  before_action :set_project
  before_action :set_payment, only: %i[destroy update]

  def create
    @payment = @project.payments.new(payment_params)

    flash.now[:notice] = 'Payment was created successfully.' if @payment.save
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

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_payment
    @payment = @project.payments.find(params[:id])
  end
end
