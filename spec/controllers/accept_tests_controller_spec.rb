# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AcceptTestsController, type: :controller do
  let(:valid_attributes) do
    {
      project_id: @project.id,
      release_id: @release.id,
      user_story_id: @user_story.id,
      name: 'Second Accept Test',
      description: 'Description...'
    }
  end

  let(:invalid_attributes) do
    {
      project_id: @project.id,
      release_id: @release.id,
      user_story_id: @user_story.id,
      name: '',
      description: ''
    }
  end

  before do
    @project    = create(:project)
    @release    = create(:release)
    @user_story = create(:user_story)
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get(:new, params: { project_id: @project.id, release_id: @release.id, user_story_id: @user_story.id })
      expect(response).to be_successful
    end

    it 'redirect without release' do
      get(:new, params: { project_id: @project.id, release_id: @release.id, user_story_id: 0 })
      expect(response).to redirect_to(release_path(@project.id, @release.id))
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      @accept_test = create(:accept_test)
      get(:edit, params: { project_id: @project.id, release_id: @release.id, user_story_id: @user_story.id, accept_test_id: @accept_test.id })
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new AcceptTest' do
        expect do
          post(:create, params: { project_id: @project.id, release_id: @release.id, user_story_id: @user_story.id, accept_test: valid_attributes })
        end.to change(AcceptTest, :count).by(1)
      end

      it 'shows flash notice' do
        post(:create, params: { project_id: @project.id, release_id: @release.id, user_story_id: @user_story.id, accept_test: valid_attributes })
        expect(flash[:notice]).to eq('Accept test was successfully created.')
      end

      it 'redirects to the created accept_test' do
        post(:create, params: { project_id: @project.id, release_id: @release.id, user_story_id: @user_story.id, accept_test: valid_attributes })
        expect(response).to redirect_to(user_story_path(@project.id, @release.id, @user_story.id))
      end
    end

    context 'with invalid params' do
      it 'does not creates a new AcceptTest' do
        expect do
          post(:create, params: { project_id: @project.id, release_id: @release.id, user_story_id: @user_story.id, accept_test: invalid_attributes })
        end.not_to change(AcceptTest, :count)
      end
    end
  end

  describe 'PUT #update' do
    before { @accept_test = create(:accept_test) }

    context 'with valid params' do
      let(:params) do
        {
          project_id: @project.id,
          release_id: @release.id,
          user_story_id: @user_story.id,
          accept_test_id: @accept_test.id,
          accept_test: valid_attributes
        }
      end

      it 'updates the requested accept_test' do
        put(:update, params: params)
        @accept_test.reload
        expect(@accept_test.name).to eq('Second Accept Test')
      end

      it 'shows flash notice' do
        put(:update, params: params)
        expect(flash[:notice]).to eq('Accept test was successfully updated.')
      end

      it 'redirects to the accept_test' do
        put(:update, params: params)
        expect(response).to redirect_to(user_story_path(@project.id, @release.id, @user_story.id))
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          project_id: @project.id,
          release_id: @release.id,
          user_story_id: @user_story.id,
          accept_test_id: @accept_test.id,
          accept_test: invalid_attributes
        }
      end

      it 'does not updates the AcceptTest' do
        expect do
          put(:update, params: params)
        end.not_to change(AcceptTest, :first)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { @accept_test = create(:accept_test) }

    it 'destroys the requested accept_test' do
      expect do
        delete(:destroy, params: { project_id: @project.id, release_id: @release.id, user_story_id: @user_story.id, accept_test_id: @accept_test.id })
      end.to change(AcceptTest, :count).by(-1)
    end

    it 'shows flash notice' do
      delete(:destroy, params: { project_id: @project.id, release_id: @release.id, user_story_id: @user_story.id, accept_test_id: @accept_test.id })
      expect(flash[:notice]).to eq('Accept test was successfully destroyed.')
    end

    it 'redirects to the accept_tests list' do
      delete(:destroy, params: { project_id: @project.id, release_id: @release.id, user_story_id: @user_story.id, accept_test_id: @accept_test.id })
      expect(response).to redirect_to(user_story_path(@project.id, @release.id, @user_story.id))
    end
  end
end
