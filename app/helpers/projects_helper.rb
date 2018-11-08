# frozen_string_literal: true

module ProjectsHelper
<<<<<<< HEAD
  def total_project_earning(project)
    project.payments.sum(:amount)
  end

  def control_links(resource)
=======
  def control_links(project)
>>>>>>> 932fd73... Displayed error messages for validation errors
    return unless current_user&.manager?

    capture do
      concat link_to('Edit', edit_project_path(project), class: 'btn btn-primary btn-round')
      concat ''
      concat link_to('Delete', project_path(project), method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-primary btn-round')
    end
  end
end
