# frozen_string_literal: true

module ClientsHelper
  def clients_list
    Client.all
  end
end
