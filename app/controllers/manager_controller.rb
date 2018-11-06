# frozen_string_literal: true

class ManagerController < ApplicationController
  before_action :manager_check, only: %i[new create destroy edit]

  private

  def manager_check
    return if current_user&.manager?

    flash[:error] = 'Only managers can perform this action'
    redirect_to root_path
  end
end
