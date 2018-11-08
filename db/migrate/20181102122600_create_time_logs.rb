# frozen_string_literal: true

class CreateTimeLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :time_logs do |t|
      t.integer :hours
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
