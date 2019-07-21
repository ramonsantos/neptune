# frozen_string_literal: true

FactoryBot.define do
  factory :release do
    name { 'First Release' }
    start_date { '2019-07-21' }
    finish_date { '2019-08-21' }
    description { 'Description' }
    active { false }
    project { nil }
  end
end
