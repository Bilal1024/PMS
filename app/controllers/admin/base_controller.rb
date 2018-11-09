# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  before_action :admin_check

  def admin_check
    return if current_user&.admin?

    redirect_to root_path, flash: { error: 'Invalid access' }
  end
end
