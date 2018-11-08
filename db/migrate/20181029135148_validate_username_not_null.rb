# frozen_string_literal: true

class ValidateUsernameNotNull < ActiveRecord::Migration[5.2]
  def up
    change_column_null :users, :username, false
  end

  def down
    change_column_null :user, :username, true
  end
end
