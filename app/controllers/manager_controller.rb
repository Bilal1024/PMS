# frozen_string_literal: true

class ManagerController < ApplicationController
  before_action :manager_check, only: %i[new create destroy edit update]

  private

  def manager_check
    return if current_user&.manager?

    redirect_to root_path, flash: { error: 'Invalid access' }
  end
end
