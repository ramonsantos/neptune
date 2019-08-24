# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReleasesController, type: :controller do
  let(:valid_attributes) do
    {
      project_id: project,
      name: 'Second Release'
    }
  end

  let(:invalid_attributes) do
    {
      project_id: project,
      name: ''
    }
  end

  let(:project) { create(:project) }

  let!(:release) { create(:release) }

  let!(:release_with_user_stories) { create(:release_with_user_stories) }

  describe 'GET #index' do
    def get_index(project_params)
      get(:index, params: { project_id: project_params })
    end

    context 'when there is a project' do
      it 'returns a success response' do
        get_index(project)
        expect(response).to be_successful
      end
    end

    context 'when there is no project' do
      it 'redirects without projects page' do
        get_index(0)
        expect(response).to redirect_to(projects_path)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get(:show, params: { project_id: project, release_id: release })
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    def get_new(project_params)
      get(:new, params: { project_id: project_params })
    end

    it 'returns a success response' do
      get_new(project)
      expect(response).to be_successful
    end

    it 'redirects without project' do
      get_new(0)
      expect(response).to redirect_to(projects_path)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get(:edit, params: { project_id: project, release_id: release })
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    def post_create(release_params)
      post(:create, params: { project_id: project, release: release_params })
    end

    context 'with valid params' do
      it 'creates a new Release' do
        expect do
          post_create(valid_attributes)
        end.to change(Release, :count).by(1)
      end

      it 'shows flash notice' do
        post_create(valid_attributes)
        expect(flash[:notice]).to eq('Release was successfully created.')
      end

      it 'redirects to the created release' do
        post_create(valid_attributes)
        expect(response).to redirect_to(release_path(project, Release.last))
      end
    end

    context 'with invalid params' do
      it 'does not creates a new Release' do
        expect do
          post_create(invalid_attributes)
        end.not_to change(Release, :count)
      end
    end
  end

  describe 'PUT #update' do
    def put_update(release_params)
      put(:update, params: { project_id: project, release_id: release, release: release_params })
    end

    context 'with valid params' do
      it 'updates the requested release' do
        put_update(valid_attributes)
        release.reload
        expect(release.name).to eq('Second Release')
      end

      it 'shows flash notice' do
        put_update(valid_attributes)
        expect(flash[:notice]).to eq('Release was successfully updated.')
      end

      it 'redirects to the release' do
        put_update(valid_attributes)
        expect(response).to redirect_to(release_path(project, release))
      end
    end

    context 'with invalid params' do
      it 'does not updates the Release' do
        expect do
          put_update(invalid_attributes)
        end.not_to change(Release, :last)
      end
    end
  end

  describe 'DELETE #destroy' do
    def delete_destroy(release)
      delete(:destroy, params: { project_id: project, release_id: release })
    end

    context 'when simple Release' do
      it 'destroys the requested releases' do
        expect do
          delete_destroy(release)
        end.to change(Release, :count).by(-1)
      end

      it 'shows flash notice' do
        delete_destroy(release)
        expect(flash[:notice]).to eq('Release was successfully destroyed.')
      end

      it 'redirects to the releases list' do
        delete_destroy(release)
        expect(response).to redirect_to(project_path(project))
      end
    end

    context 'when release with UserStory' do
      it 'destroys the requested releases' do
        expect do
          delete_destroy(release_with_user_stories)
        end.to change(Release, :count).by(-1)
      end

      it 'destroys UserStories from requested releases' do
        expect do
          delete_destroy(release_with_user_stories)
        end.to change(UserStory, :count).by(-1)
      end

      it 'redirects to the releases list' do
        delete_destroy(release_with_user_stories)
        expect(response).to redirect_to(project_path(project))
      end
    end
  end
end
