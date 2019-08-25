# frozen_string_literal: true

Rails.application.routes.draw do
  root 'projects#index'

  devise_for :users

  resources :projects, param: :project_id do
    member do
      resources :releases, param: :release_id do
        member do
          resources :user_stories, param: :user_story_id, except: [:index] do
            member do
              resources :accept_tests, param: :accept_test_id, except: [:index, :show]

              resources :tasks, param: :task_id, except: [:index, :show]
            end
          end
        end
      end
    end
  end
end
