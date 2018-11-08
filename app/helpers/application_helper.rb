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
<<<<<<< HEAD
=======

  def authenticate_manager
    current_user&.manager?
  end

  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info'
    when 'alert' then 'alert alert-danger'
    end
  end

  def error_class(resource, field)
    resource.errors[field].any? ? 'form-group has-danger' : 'form-group'
  end

  def errors_div(resource, field)
    content_tag :div, class: 'notice text-danger' do
      resource.errors[field].to_sentence if resource.errors[field].any?
    end
  end
>>>>>>> 932fd73... Displayed error messages for validation errors
end
