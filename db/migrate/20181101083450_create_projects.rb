# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name, index: { unique: true }, limit: 50, null: false
      t.text :description
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
