class RemoveDescriptionFromRelease < ActiveRecord::Migration[6.0]
  def change
    remove_column :releases, :description, :text
  end
end
