# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :releases, dependent: :delete_all
  belongs_to :user

  validates :name, presence: true
  validates :user, presence: true
end
