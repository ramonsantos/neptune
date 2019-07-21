# frozen_string_literal: true

Rails.application.routes.draw do
  root 'projects#index'

  resources :projects
  resources :releases
end
