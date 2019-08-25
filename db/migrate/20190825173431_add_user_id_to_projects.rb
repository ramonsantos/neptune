# frozen_string_literal: true

class AddUserIdToProjects < ActiveRecord::Migration[6.0]
  def change
    add_reference :projects, :user, index: true, foreign_key: true
  end
end
