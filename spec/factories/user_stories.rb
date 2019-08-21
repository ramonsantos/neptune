# frozen_string_literal: true

FactoryBot.define do
  factory :user_story do
    release

    name { 'Add new projects' }
    description { 'Description...' }
    situation { 'todo' }
  end
end
