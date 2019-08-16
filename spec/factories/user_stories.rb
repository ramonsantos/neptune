# frozen_string_literal: true

FactoryBot.define do
  factory :user_story do
    release

    number { 1 }
    name { 'Add new projects' }
    description { 'Description...' }
  end
end