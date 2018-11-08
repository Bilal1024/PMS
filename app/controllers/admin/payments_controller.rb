# frozen_string_literal: true

class Admin::PaymentsController < Admin::BaseController
  before_action :find_project
  before_action :find_payment, only: %i[destroy update]

  def create
    @payment = @project.payments.new(payment_params)

    flash.now[:notice] = 'Payment was created successfully.' if @payment.save
  end

  def update
    @payment.update(payment_params)
    respond_with_bip(@payment)
  end

  def destroy
    @payment.destroy
    redirect_to admin_project_path(@project), notice: 'Payment was deleted successfully.'
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
