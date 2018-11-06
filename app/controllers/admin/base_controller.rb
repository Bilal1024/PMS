# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  before_action :admin_check

  def admin_check
    return if current_user &. admin?

    flash[:error] = 'Only admins can access this part of the website'
    redirect_to root_path
  end
end
