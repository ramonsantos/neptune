# frozen_string_literal: true

Rails.application.routes.draw do
  root 'projects#index'

  resources :projects, param: :project_id do
    member do
      resources :releases, param: :release_id do
        member do
          resources :user_stories, param: :user_story_id
        end
      end
    end
  end
end
