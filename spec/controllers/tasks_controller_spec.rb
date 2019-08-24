# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:project) { create(:project) }

  let(:release) { create(:release) }

  let(:user_story) { create(:user_story) }

  let!(:task) { create(:task) }

  let(:valid_attributes) do
    {
      project_id: project,
      release_id: release,
      user_story_id: user_story,
      name: 'Second Task',
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
    it 'returns a success response' do
      get(:edit, params: { project_id: project, release_id: release, user_story_id: user_story, task_id: task })
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    def post_create(task_params)
      params = { project_id: project, release_id: release, user_story_id: user_story, task: task_params }
      post(:create, params: params)
    end

    context 'with valid params' do
      it 'creates a new task' do
        expect do
          post_create(valid_attributes)
        end.to change(Task, :count).by(1)
      end

      it 'shows flash notice' do
        post_create(valid_attributes)
        expect(flash[:notice]).to eq('Task was successfully created.')
      end

      it 'redirects to the created task' do
        post_create(valid_attributes)
        expect(response).to redirect_to(user_story_path(project, release, user_story))
      end
    end

    context 'with invalid params' do
      it 'does not creates a new task' do
        expect do
          post_create(invalid_attributes)
        end.not_to change(Task, :count)
      end
    end
  end

  describe 'PUT #update' do
    def put_update(task_params)
      params = {
        project_id: project,
        release_id: release,
        user_story_id: user_story,
        task_id: task,
        task: task_params
      }
      put(:update, params: params)
    end

    context 'with valid params' do
      it 'updates the requested task' do
        put_update(valid_attributes)
        task.reload
        expect(task.name).to eq('Second Task')
      end

      it 'shows flash notice' do
        put_update(valid_attributes)
        expect(flash[:notice]).to eq('Task was successfully updated.')
      end

      it 'redirects to the task' do
        put_update(valid_attributes)
        expect(response).to redirect_to(user_story_path(project, release, user_story))
      end
    end

    context 'with invalid params' do
      it 'does not updates the task' do
        expect do
          put_update(invalid_attributes)
        end.not_to change(Task, :first)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:params) do
      { project_id: project, release_id: release, user_story_id: user_story, task_id: task }
    end

    it 'destroys the requested task' do
      expect do
        delete(:destroy, params: params)
      end.to change(Task, :count).by(-1)
    end

    it 'shows flash notice' do
      delete(:destroy, params: params)
      expect(flash[:notice]).to eq('Task was successfully destroyed.')
    end

    it 'redirects to the tasks list' do
      delete(:destroy, params: params)
      expect(response).to redirect_to(user_story_path(project, release, user_story))
    end
  end
end
