# frozen_string_literal: true

FactoryBot.define do
  factory :release do
    name { 'First Release' }
    project

    trait :default do
      start_date { '2019-07-21' }
      finish_date { '2019-08-21' }
      active { false }
    end

    trait :with_user_stories do
      after(:create) { |release| create(:user_story, release: release) }
    end

    factory :release_default, traits: %i[default]
    factory :release_with_user_stories, traits: %i[with_user_stories]
  end
end
