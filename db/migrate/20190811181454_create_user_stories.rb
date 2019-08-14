class CreateUserStories < ActiveRecord::Migration[6.0]
  def change
    create_table :user_stories do |t|
      t.integer :number
      t.string :name
      t.text :description
      t.references :release, null: false, foreign_key: true

      t.timestamps
    end
  end
end
