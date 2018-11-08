# frozen_string_literal: true

module ClientsHelper
  def clients_list
    Client.all
  end

  def managers_list
    User.where(role: :manager)
  end
end
