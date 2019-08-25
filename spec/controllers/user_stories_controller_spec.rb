# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserStoriesController, type: :controller do
  login_user

  let!(:project) { create(:project) }

  let!(:release) { create(:release) }

  let!(:user_story) { create(:user_story) }

  let!(:user_story_with_tasks) { create(:user_story_with_tasks) }

  let!(:user_story_with_accept_tests) { create(:user_story_with_accept_tests) }

  let(:valid_attributes) do
    {
      project_id: project,
      release_id: release,
      name: 'Second User Story',
      description: 'Description...'
    }
  end

  let(:invalid_attributes) do
    {
      project_id: project,
      release_id: release,
      name: 'Second User Story',
      description: ''
    }
  end

  let(:resource_params) do
    { project_id: project, release_id: release, user_story_id: user_story }
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get(:show, params: resource_params)
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    def get_new(release_id)
      get(:new, params: { project_id: project, release_id: release_id })
    end

    it 'returns a success response' do
      get_new(release)
      expect(response).to be_successful
    end

    it 'redirects without release' do
      get_new(0)
      expect(response).to redirect_to(project_path(project))
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get(:edit, params: resource_params)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    def post_create(user_story_params)
      post(:create, params: { project_id: project, release_id: release, user_story: user_story_params })
    end

    context 'with valid params' do
      it 'creates a new user story' do
        expect do
          post_create(valid_attributes)
        end.to change(UserStory, :count).by(1)
      end

      it 'shows flash notice' do
        post_create(valid_attributes)
        expect(flash[:notice]).to eq('User story was successfully created.')
      end

      it 'redirects to the created user_story' do
        post_create(valid_attributes)
        expect(response).to redirect_to(release_path(project, release))
      end
    end

    context 'with invalid params' do
      it 'does not creates a new user story' do
        expect do
          post_create(invalid_attributes)
        end.not_to change(Project, :count)
      end
    end
  end

  describe 'PUT #update' do
    def put_update(user_story_params)
      params = {
        project_id: project,
        release_id: release,
        user_story_id: user_story,
        user_story: user_story_params
      }

      put(:update, params: params)
    end

    context 'with valid params' do
      before { put_update(valid_attributes) }

      it 'updates the requested user story' do
        user_story.reload
        expect(user_story.name).to eq('Second User Story')
      end

      it 'shows flash notice' do
        expect(flash[:notice]).to eq('User story was successfully updated.')
      end

      it 'redirects to the user story' do
        expect(response).to redirect_to(release_path(project, release))
      end
    end

    context 'with invalid params' do
      it 'does not updates the user story' do
        expect do
          put_update(invalid_attributes)
        end.not_to change(UserStory, :first)
      end
    end
  end

  describe 'DELETE #destroy' do
    def delete_destroy(user_story_id)
      delete(:destroy, params: { project_id: project, release_id: release, user_story_id: user_story_id })
    end

    context 'when simple user story' do
      it 'destroys the requested user story' do
        expect do
          delete_destroy(user_story)
        end.to change(UserStory, :count).by(-1)
      end

      it 'shows flash notice' do
        delete_destroy(user_story)
        expect(flash[:notice]).to eq('User story was successfully destroyed.')
      end

      it 'redirects to the release page' do
        delete_destroy(user_story)
        expect(response).to redirect_to(release_path(project, release))
      end
    end

    context 'when user story with Tasks' do
      it 'destroys the requested user story' do
        expect do
          delete_destroy(user_story_with_tasks)
        end.to change(UserStory, :count).by(-1)
      end

      it 'destroys Tasks from requested user story' do
        expect do
          delete_destroy(user_story_with_tasks)
        end.to change(Task, :count).by(-1)
      end

      it 'redirects to the release page' do
        delete_destroy(user_story_with_tasks)
        expect(response).to redirect_to(release_path(project, release))
      end
    end

    context 'when user story with AcceptTest' do
      it 'destroys the requested user story' do
        expect do
          delete_destroy(user_story_with_accept_tests)
        end.to change(UserStory, :count).by(-1)
      end

      it 'destroys AcceptTest from requested user story' do
        expect do
          delete_destroy(user_story_with_accept_tests)
        end.to change(AcceptTest, :count).by(-1)
      end

      it 'redirects to the release page' do
        delete_destroy(user_story_with_accept_tests)
        expect(response).to redirect_to(release_path(project, release))
      end
    end
  end
end
