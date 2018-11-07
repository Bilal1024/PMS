# frozen_string_literal: true

class PaymentsController < ManagerController
  before_action :set_project
  before_action :set_payment, only: %i[destroy update]

  def create
    @payment = @project.payments.new(payment_params)

    flash[:notice] = 'successfully added payment' if @payment.save
  end

  def destroy
    @payment.destroy
    flash[:notice] = 'successfully deleted payment'
    redirect_to project_path(@project)
  end

  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to(@payment, notice: 'payment was successfully updated.') }
      else
        format.html { render action: 'edit' }
      end

      format.json { respond_with_bip(@payment) }
    end
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
