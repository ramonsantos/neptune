# frozen_string_literal: true

require 'rails_helper'

describe ProjectsController, type: :controller do
  let(:valid_attributes) { attributes_for(:project) }

  let(:invalid_attributes) { attributes_for(:project, name: nil) }

  let(:project) { create(:project) }

  let(:project_with_releases) { create(:project_with_releases) }

  describe 'GET #index' do
    it 'returns a success response' do
      get(:index, params: {})
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get(:show, params: { project_id: create(:project).to_param })
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get(:new)
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get(:edit, params: { project_id: create(:project).to_param })
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Project' do
        expect do
          post(:create, params: { project: valid_attributes })
        end.to change(Project, :count).by(1)
      end

      it 'shows flash notice' do
        post(:create, params: { project: valid_attributes })
        expect(flash[:notice]).to eq('Project was successfully created.')
      end

      it 'redirects to the created project' do
        post(:create, params: { project: valid_attributes })
        expect(response).to redirect_to(Project.last)
      end
    end

    context 'with invalid params' do
      it 'does not creates a new Project' do
        expect do
          post(:create, params: { project: invalid_attributes })
        end.not_to change(Project, :count)
      end
    end
  end

  describe 'PUT #update' do
    before { project }

    context 'with valid params' do
      let(:new_attributes) { { name: 'New Name' } }

      it 'updates the requested project' do
        put(:update, params: { project_id: project.to_param, project: new_attributes })
        project.reload
        expect(project.name).to eq('New Name')
      end

      it 'shows flash notice' do
        put(:update, params: { project_id: project.to_param, project: new_attributes })
        expect(flash[:notice]).to eq('Project was successfully updated.')
      end

      it 'redirects to the project' do
        put(:update, params: { project_id: project.to_param, project: valid_attributes })
        expect(response).to redirect_to(project)
      end
    end

    context 'with invalid params' do
      it 'does not updates the Project' do
        expect do
          put(:update, params: { project_id: project.to_param, project: invalid_attributes })
        end.not_to change(Project, :first)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when simple Project' do
      before { project }

      it 'destroys the requested project' do
        expect do
          delete(:destroy, params: { project_id: project.to_param })
        end.to change(Project, :count).by(-1)
      end

      it 'shows flash notice' do
        delete(:destroy, params: { project_id: project.to_param })
        expect(flash[:notice]).to eq('Project was successfully destroyed.')
      end

      it 'redirects to the projects list' do
        delete(:destroy, params: { project_id: project.to_param })
        expect(response).to redirect_to(projects_path)
      end
    end

    context 'when Project with Releases' do
      before { project_with_releases }

      it 'destroys the requested project' do
        expect do
          delete(:destroy, params: { project_id: project_with_releases.to_param })
        end.to change(Project, :count).by(-1)
      end

      it 'destroys Releases from requested project' do
        expect do
          delete(:destroy, params: { project_id: project_with_releases.to_param })
        end.to change(Release, :count).by(-1)
      end

      it 'redirects to the projects list' do
        delete(:destroy, params: { project_id: project_with_releases.to_param })
        expect(response).to redirect_to(projects_path)
      end
    end
  end
end
