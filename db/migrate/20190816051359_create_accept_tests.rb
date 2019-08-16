class CreateAcceptTests < ActiveRecord::Migration[6.0]
  def change
    create_table :accept_tests do |t|
      t.string :name
      t.text :description
      t.references :user_story, null: false, foreign_key: true

      t.timestamps
    end
  end
end
