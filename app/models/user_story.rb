# frozen_string_literal: true

class UserStory < ApplicationRecord
  belongs_to :release
  has_many :accept_tests, dependent: :delete_all
  has_many :tasks, dependent: :delete_all

  enum situation: {
         todo: 'To Do', doing: 'Doing', done: 'Done', aborted: 'Aborted'
       }

  validates :name, presence: true
  validates :description, presence: true
  validates :situation, presence: true
  validates :release_id, presence: true
end
