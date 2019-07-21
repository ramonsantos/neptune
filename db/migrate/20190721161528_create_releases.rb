# frozen_string_literal: true

class CreateReleases < ActiveRecord::Migration[6.0]
  def change
    create_table :releases do |t|
      t.string :name
      t.date :start_date
      t.date :finish_date
      t.text :description
      t.boolean :active
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
