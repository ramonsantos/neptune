# frozen_string_literal: true

Rails.application.routes.draw do
  root 'projects#index'

  resources :projects, param: :project_id do
    member do
      resources :releases, param: :release_id do
        member do
          resources :user_stories, param: :user_story_id do
            member do
              resources :accept_tests, param: :accept_test_id

              resources :tasks, param: :task_id
            end
          end
        end
      end
    end
  end
end
