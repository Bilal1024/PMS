class ManagerController < ApplicationController
  before_action :manager_check, only: [:new, :create, :destroy, :edit]

  private

  def manager_check
    unless current_user.manager?
      flash[:error] = 'Only managers can perform this action'
      redirect_to root_path
    end
  end
end
