# frozen_string_literal: true

module Admin::UsersHelper
  def roles_list
    User.roles.keys.reject { |role| role == User::ADMIN }
  end

  def users_array
    User.non_admin_users.pluck(:id, :username)
  end

  def users_list
    User.non_admin_users
  end
end
