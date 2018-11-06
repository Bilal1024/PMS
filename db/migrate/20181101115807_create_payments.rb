# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :amount, null: false
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
