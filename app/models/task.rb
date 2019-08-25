# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user_story

  validates :description,   presence: true
  validates :name,          presence: true
  validates :user_story_id, presence: true
end
