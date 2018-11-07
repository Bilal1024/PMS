# frozen_string_literal: true

module TimeLogsHelper
  def authenticate_user(time_log)
    current_user && time_log.user_id == current_user.id
  end
end
