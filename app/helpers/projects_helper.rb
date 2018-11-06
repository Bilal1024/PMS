module ProjectsHelper
  def total_project_earning(project)
    project.payments.sum(:amount)
  end

  def control_links(resource)
    if current_user.manager?
      link_to("Edit", edit_project_path(resource), class: "btn btn-primary btn-round") +
      link_to("Delete", project_path(resource), method: :delete, data: { confirm: 'Are you sure?' }, class: "btn btn-primary btn-round")
    end
  end
end
