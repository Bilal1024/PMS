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
    'has-danger' if resource.errors[field].any?
  end

  def errors_div(resource, field)
    return unless resource.errors[field].any?

    content_tag :div, class: 'notice text-danger' do
      resource.errors.full_messages_for(field).to_sentence.humanize
    end
  end

  def attachment_error_class(resource, fields)
    fields.each do |field|
      return 'has-danger' if resource.errors[field].any?
    end
  end

  def attachment_errors_div(resource, fields)
    errors = []
    fields.each do |field|
      errors << resource.errors.full_messages_for(field).to_sentence if resource.errors[field].any?
    end

    content_tag :div, class: 'notice text-danger' do
      errors.to_sentence.humanize
    end
  end

  def build_attachment_association(resource)
    resource.attachment || resource.build_attachment
  end

  def alert_class(key)
    case key
    when 'notice' then 'success'
    when 'alert' then 'danger'
    when 'error' then 'danger'
    else key
    end
  end
end
