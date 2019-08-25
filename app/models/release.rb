# frozen_string_literal: true

class Release < ApplicationRecord
  belongs_to :project
  has_many   :user_stories, dependent: :delete_all

  validates :name,       presence: true
  validates :project_id, presence: true
end
