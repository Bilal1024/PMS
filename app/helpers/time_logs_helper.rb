module TimeLogsHelper
  def authenticate_user(project, time_log)
    time_log.user == current_user
  end
end
