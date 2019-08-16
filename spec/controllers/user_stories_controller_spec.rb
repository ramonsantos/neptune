# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserStoriesController, type: :controller do
  let(:valid_attributes) do
    {
      project_id: @project.id,
      release_id: @release.id,
      name: 'Second User Story',
      description: 'Description...'
    }
  end

  let(:invalid_attributes) do
    {
      project_id: @project.id,
      release_id: @release.id,
      name: 'Second User Story',
      description: ''
    }
  end

  let(:resource_params) do
    { project_id: @project.id, release_id: @release.id, user_story_id: @user_story.id }
  end

  before do
    @project = create(:project)
    @release = create(:release)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get(:index, params: { project_id: @project.id, release_id: @release.id })
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      @user_story = create(:user_story)
      get(:show, params: resource_params)
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get(:new, params: { project_id: @project.id, release_id: @release.id })
      expect(response).to be_successful
    end

    it 'redirect without release' do
      get(:new, params: { project_id: @project.id, release_id: 0 })
      expect(response).to redirect_to(project_path(@project.id))
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      @user_story = create(:user_story)
      get(:edit, params: resource_params)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new UserStory' do
        expect do
          post(:create, params: { project_id: @project.id, release_id: @release.id, user_story: valid_attributes })
        end.to change(UserStory, :count).by(1)
      end

      it 'redirects to the created user_story' do
        post(:create, params: { project_id: @project.id, release_id: @release.id, user_story: valid_attributes })
        expect(response).to redirect_to(release_path(@project.id, Release.last.id))
      end
    end

    context 'with invalid params' do
      it 'does not creates a new Release' do
        expect do
          post(:create, params: { project_id: @project.id, release_id: @release.id, user_story: invalid_attributes })
        end.not_to change(Project, :count)
      end
    end
  end

  describe 'PUT #update' do
    before { @user_story = create(:user_story) }

    context 'with valid params' do
      let(:params) do
        {
          project_id: @project.id,
          release_id: @release.id,
          user_story_id: @user_story.id,
          user_story: valid_attributes
        }
      end

      it 'updates the requested user_story' do
        put(:update, params: params)
        @user_story.reload
        expect(@user_story.name).to eq('Second User Story')
      end

      it 'redirects to the user_story' do
        put(:update, params: params)
        expect(response).to redirect_to(release_path(@project.id, @release.id))
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          project_id: @project.id,
          release_id: @release.id,
          user_story_id: @user_story.id,
          user_story: invalid_attributes
        }
      end

      it 'does not updates the Release' do
        expect do
          put(:update, params: params)
        end.not_to change(UserStory, :first)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { @user_story = create(:user_story) }

    it 'destroys the requested user_story' do
      expect do
        delete(:destroy, params: resource_params)
      end.to change(UserStory, :count).by(-1)
    end

    it 'redirects to the release page' do
      delete(:destroy, params: resource_params)
      expect(response).to redirect_to(release_path(@project.id, @release.id))
    end
  end
end
