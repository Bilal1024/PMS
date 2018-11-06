# frozen_string_literal: true

class PaymentsController < ManagerController
  before_action :find_project
  before_action :find_payment, only: %i[destroy update]

  def create
    @payment = @project.payments.new(payment_params)

    if @payment.save
      flash[:notice] = 'successfully added payment'
      redirect_to project_path(@project)
    else
      @project.payments.delete(@payment)
      render('projects/show')
    end
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

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_payment
    @payment = @project.payments.find(params[:id])
  end
end
