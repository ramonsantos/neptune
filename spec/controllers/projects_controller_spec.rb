# frozen_string_literal: true

require 'rails_helper'

describe ProjectsController, type: :controller do
  login_user

  let(:valid_attributes) { attributes_for(:project) }

  let(:invalid_attributes) { attributes_for(:project, name: nil) }

  let(:project) { create(:project) }

  let!(:project_with_releases) { create(:project_with_releases) }

  let(:get_params) { { project_id: create(:project) } }

  describe 'GET #index' do
    it 'returns a success response' do
      get(:index)
      expect(response).to be_successful
    end

    context 'when user is not authorized' do
      before do
        sign_out(User.last)
        get(:index)
      end

      it 'returns a redirect response' do
        expect(response).to have_http_status(302)
      end

      it 'redirects to login page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get(:show, params: get_params)
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
      get(:edit, params: get_params)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    def post_create(params)
      post(:create, params: { project: params })
    end

    context 'with valid params' do
      it 'creates a new project' do
        expect do
          post_create(valid_attributes)
        end.to change(Project, :count).by(1)
      end

      it 'shows flash notice' do
        post_create(valid_attributes)
        expect(flash[:notice]).to eq('Project was successfully created.')
      end

      it 'redirects to the created project' do
        post_create(valid_attributes)
        expect(response).to redirect_to(Project.last)
      end
    end

    context 'with invalid params' do
      it 'does not creates a new project' do
        expect do
          post_create(invalid_attributes)
        end.not_to change(Project, :count)
      end
    end
  end

  describe 'PUT #update' do
    def put_update(project_params)
      put(:update, params: { project_id: project, project: project_params })
    end

    before { project }

    context 'with valid params' do
      let(:new_attributes) { { name: 'New Name' } }

      it 'updates the requested project' do
        put_update(new_attributes)
        project.reload
        expect(project.name).to eq('New Name')
      end

      it 'shows flash notice' do
        put_update(new_attributes)
        expect(flash[:notice]).to eq('Project was successfully updated.')
      end

      it 'redirects to the project' do
        put_update(new_attributes)
        expect(response).to redirect_to(project)
      end
    end

    context 'with invalid params' do
      it 'does not updates the project' do
        expect do
          put_update(invalid_attributes)
        end.not_to change(Project, :first)
      end
    end
  end

  describe 'DELETE #destroy' do
    def delete_destroy(project_params)
      delete(:destroy, params: { project_id: project_params })
    end

    context 'when simple project' do
      before { project }

      it 'destroys the requested project' do
        expect do
          delete_destroy(project)
        end.to change(Project, :count).by(-1)
      end

      it 'shows flash notice' do
        delete_destroy(project)
        expect(flash[:notice]).to eq('Project was successfully destroyed.')
      end

      it 'redirects to the projects list' do
        delete_destroy(project)
        expect(response).to redirect_to(projects_path)
      end
    end

    context 'when project with Releases' do
      it 'destroys the requested project' do
        expect do
          delete_destroy(project_with_releases)
        end.to change(Project, :count).by(-1)
      end

      it 'destroys Releases from requested project' do
        expect do
          delete_destroy(project_with_releases)
        end.to change(Release, :count).by(-1)
      end

      it 'redirects to the projects list' do
        delete_destroy(project_with_releases)
        expect(response).to redirect_to(projects_path)
      end
    end
  end
end
