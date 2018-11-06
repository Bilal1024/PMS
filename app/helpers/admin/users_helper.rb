module Admin::UsersHelper
  def roles_list
    User.roles.keys.reject{ |role| role == User::ADMIN }
  end

  def users_array
    User.where.not(role: :admin).pluck(:id, :username)
  end

  def users_list
    User.where.not(role: :admin)
  end
end
