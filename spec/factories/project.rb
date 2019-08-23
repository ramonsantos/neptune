# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { 'Neptune' }
    description { 'A User Stories manager' }
    start_date { DateTime.new(2019, 6, 29) }

    trait :with_releases do
      after(:create) do |project|
        create(:release, project: project)
      end
    end

    factory :project_with_releases, traits: [:with_releases]
  end
end
