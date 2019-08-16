# frozen_string_literal: true

class UserStory < ApplicationRecord
  belongs_to :release
  has_many :accept_tests

  validates :name,        presence: true
  validates :description, presence: true
  validates :release_id,  presence: true
end
