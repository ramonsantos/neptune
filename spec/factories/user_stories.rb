# frozen_string_literal: true

FactoryBot.define do
  factory :user_story do
    release

    name { 'Add new projects' }
    description { 'Description...' }
    situation { 'todo' }

    trait :with_tasks do
      after(:create) { |user_story| create(:task, user_story: user_story) }
    end

    trait :with_accept_tests do
      after(:create) do |user_story|
        create(:accept_test, user_story: user_story)
      end
    end

    factory :user_story_with_tasks, traits: %i[with_tasks]
    factory :user_story_with_accept_tests, traits: %i[with_accept_tests]
  end
end
