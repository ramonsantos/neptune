# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AcceptTestsController, type: :controller do
  let(:project) { create(:project) }

  let(:release) { create(:release) }

  let(:user_story) { create(:user_story) }

  let!(:accept_test) { create(:accept_test) }

  let(:valid_attributes) do
    {
      project_id: project,
      release_id: release,
      user_story_id: user_story,
      name: 'Second Accept Test',
      description: 'Description...'
    }
  end

  let(:invalid_attributes) do
    {
      project_id: project,
      release_id: release,
      user_story_id: user_story,
      name: '',
      description: ''
    }
  end

  describe 'GET #new' do
    def get_new(user_story_id)
      get(:new, params: { project_id: project, release_id: release, user_story_id: user_story_id })
    end

    it 'returns a success response' do
      get_new(user_story)
      expect(response).to be_successful
    end

    it 'redirects without release' do
      get_new(0)
      expect(response).to redirect_to(release_path(project, release))
    end
  end

  describe 'GET #edit' do
    let(:params) do
      { project_id: project, release_id: release, user_story_id: user_story, accept_test_id: accept_test }
    end

    it 'returns a success response' do
      get(:edit, params: params)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    def post_create(accept_test_params)
      params = {
        project_id: project,
        release_id: release,
        user_story_id: user_story,
        accept_test: accept_test_params
      }
      post(:create, params: params)
    end

    context 'with valid params' do
      it 'creates a new accept test' do
        expect do
          post_create(valid_attributes)
        end.to change(AcceptTest, :count).by(1)
      end

      it 'shows flash notice' do
        post_create(valid_attributes)
        expect(flash[:notice]).to eq('Accept test was successfully created.')
      end

      it 'redirects to the created accept test' do
        post_create(valid_attributes)
        expect(response).to redirect_to(user_story_path(project, release, user_story))
      end
    end

    context 'with invalid params' do
      it 'does not creates a new accept test' do
        expect do
          post_create(invalid_attributes)
        end.not_to change(AcceptTest, :count)
      end
    end
  end

  describe 'PUT #update' do
    def put_update(accept_test_params)
      params = {
        project_id: project,
        release_id: release,
        user_story_id: user_story,
        accept_test_id: accept_test,
        accept_test: accept_test_params
      }
      put(:update, params: params)
    end

    context 'with valid params' do
      it 'updates the requested accept test' do
        put_update(valid_attributes)
        accept_test.reload
        expect(accept_test.name).to eq('Second Accept Test')
      end

      it 'shows flash notice' do
        put_update(valid_attributes)
        expect(flash[:notice]).to eq('Accept test was successfully updated.')
      end

      it 'redirects to the accept test' do
        put_update(valid_attributes)
        expect(response).to redirect_to(user_story_path(project, release, user_story))
      end
    end

    context 'with invalid params' do
      it 'does not updates the accept test' do
        expect do
          put_update(invalid_attributes)
        end.not_to change(AcceptTest, :last)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:params) do
      { project_id: project, release_id: release, user_story_id: user_story, accept_test_id: accept_test }
    end

    it 'destroys the requested accept test' do
      expect do
        delete(:destroy, params: params)
      end.to change(AcceptTest, :count).by(-1)
    end

    it 'shows flash notice' do
      delete(:destroy, params: params)
      expect(flash[:notice]).to eq('Accept test was successfully destroyed.')
    end

    it 'redirects to the accept tests list' do
      delete(:destroy, params: params)
      expect(response).to redirect_to(user_story_path(project, release, user_story))
    end
  end
end
