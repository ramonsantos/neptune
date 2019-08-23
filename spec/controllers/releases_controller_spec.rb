# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReleasesController, type: :controller do
  let(:valid_attributes) do
    {
      project_id: @project.id,
      name: 'Second Release'
    }
  end

  let(:invalid_attributes) do
    {
      project_id: @project.id,
      name: ''
    }
  end

  before { @project = create(:project) }

  describe 'GET #index' do
    context 'when there is a project' do
      it 'returns a success response' do
        get(:index, params: { project_id: @project.id })
        expect(response).to be_successful
      end
    end

    context 'when there is no project' do
      it 'returns a success response' do
        get(:index, params: { project_id: 0 })
        expect(response).to redirect_to(projects_path)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      release = create(:release)
      get(:show, params: { project_id: @project, release_id: release.to_param })
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get(:new, params: { project_id: @project.id })
      expect(response).to be_successful
    end

    it 'redirect without project' do
      get(:new, params: { project_id: 0 })
      expect(response).to redirect_to(projects_path)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      release = create(:release)
      get(:edit, params: { project_id: @project, release_id: release.to_param })
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Release' do
        expect do
          post(:create, params: { project_id: @project.id, release: valid_attributes })
        end.to change(Release, :count).by(1)
      end

      it 'redirects to the created release' do
        post(:create, params: { project_id: @project.id, release: valid_attributes })
        expect(response).to redirect_to(release_path(@project.id, Release.last.id))
      end
    end

    context 'with invalid params' do
      it 'does not creates a new Release' do
        expect do
          post(:create, params: { project_id: @project.id, release: invalid_attributes })
        end.not_to change(Release, :count)
      end
    end
  end

  describe 'PUT #update' do
    before { @release = create(:release) }

    context 'with valid params' do
      let(:params) do
        {
          project_id: @project.id,
          release_id: @release.id,
          release: valid_attributes
        }
      end

      it 'updates the requested release' do
        put(:update, params: params)
        @release.reload
        expect(@release.name).to eq('Second Release')
      end

      it 'redirects to the release' do
        put(:update, params: params)
        expect(response).to redirect_to(release_path(@project.id, Release.last.id))
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          project_id: @project.id,
          release_id: @release.id,
          release: invalid_attributes
        }
      end

      it 'does not updates the Release' do
        expect do
          put(:update, params: params)
        end.not_to change(Release, :first)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:params) do
      {
        project_id: @project.id,
        release_id: @release.id
      }
    end

    context 'when simple Release' do
      before { @release = create(:release) }

      it 'destroys the requested releases' do
        expect do
          delete(:destroy, params: params)
        end.to change(Release, :count).by(-1)
      end

      it 'redirects to the releases list' do
        delete(:destroy, params: params)
        expect(response).to redirect_to(project_path(@project))
      end
    end

    context 'when release with UserStory' do
      before { @release = create(:release_with_user_stories) }

      it 'destroys the requested releases' do
        expect do
          delete(:destroy, params: params)
        end.to change(Release, :count).by(-1)
      end

      it 'destroys UserStories from requested releases' do
        expect do
          delete(:destroy, params: params)
        end.to change(UserStory, :count).by(-1)
      end

      it 'redirects to the releases list' do
        delete(:destroy, params: params)
        expect(response).to redirect_to(project_path(@project))
      end
    end
  end
end
