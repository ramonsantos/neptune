# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :releases, dependent: :delete_all

  validates :name, presence: true
end
