# frozen_string_literal: true

class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: %i[update show destroy edit toggle_active]

  def index
    @users = User.non_admin_users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'successfully added User'
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def toggle_active
    @user.toggle_active
    redirect_back fallback_location: admin_users_path
  end

  def update
    if @user.update_without_password(user_params)
      redirect_to admin_user_path(@user)
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  def edit; end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :active, :role)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
