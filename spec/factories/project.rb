# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { 'Neptune' }
    description { 'A User Stories manager' }
    start_date { DateTime.new(2_019, 6, 29) }

    trait :with_releases do
      after(:create) { |project| create(:release, project: project) }
    end

    factory :project_with_releases, traits: %i[with_releases]
  end
end
