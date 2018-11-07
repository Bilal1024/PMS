# frozen_string_literal: true

module ApplicationHelper
  def titleize(title)
    title.to_s.humanize
  end

  def user_status(flag)
    flag ? 'Active' : 'Not Active'
  end

  def url_for_client
    current_user.admin? ? admin_clients_url : clients_url
  end

  def url_for_project
    current_user.admin? ? admin_projects_url : projects_url
  end

  def url_for_root
    current_user.admin? ? admin_projects_url : root_url
  end

  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info'
    when 'alert' then 'alert alert-danger'
    end
  end
end
