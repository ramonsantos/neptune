# frozen_string_literal: true

class Release < ApplicationRecord
  validates :name, presence: true
  validates :project_id, presence: true

  belongs_to :project
  has_many :user_stories, dependent: :delete_all
end
