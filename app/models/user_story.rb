# frozen_string_literal: true

class UserStory < ApplicationRecord
  belongs_to :release

  validates :name, presence: true
end
