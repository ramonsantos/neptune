# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'ramonsantos.pe@gmail.com' }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
