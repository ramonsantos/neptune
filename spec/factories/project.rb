# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { 'Neptune' }
    description { 'A User Stories manager' }
    start_date { DateTime.new(2019, 6, 29) }
  end
end
