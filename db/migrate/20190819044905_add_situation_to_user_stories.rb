# frozen_string_literal: true

class AddSituationToUserStories < ActiveRecord::Migration[6.0]
  def change
    add_column :user_stories, :situation, :string, default: 'To Do'
  end
end
