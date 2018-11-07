# frozen_string_literal: true

class Admin::PaymentsController < Admin::BaseController
  before_action :set_project
  before_action :set_payment, only: %i[destroy update]

  def create
    @payment = @project.payments.new(payment_params)

    if @payment.save
      flash[:notice] = 'successfully added payment'
      redirect_to admin_project_path(@project)
    else
      @project.payments.delete(@payment)
      render('admin/projects/show')
    end
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

  def destroy
    @payment.destroy
    redirect_to admin_project_path(@project)
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
