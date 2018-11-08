# frozen_string_literal: true

class AddAttributesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :role, :string
    add_column :users, :active, :boolean, default: true
  end
end
