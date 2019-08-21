class RemoveNumberFromUserStory < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_stories, :number, :integer
  end
end
