# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    user_story

    name { 'Add projects CRUD' }
    description { 'Description...' }
  end
end
