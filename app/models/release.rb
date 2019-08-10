# frozen_string_literal: true

class Release < ApplicationRecord
  validates :name, presence: true
  validates :project_id, presence: true

  belongs_to :project
end
