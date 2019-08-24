# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:valid_attributes) do
    {
      project_id: @project.id,
      release_id: @release.id,
      user_story_id: @user_story.id,
      name: 'Second Task',
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
    @project = create(:project)
    @release = create(:release)
    @user_story = create(:user_story)
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get(
        :new,
        params: {
          project_id: @project.id,
          release_id: @release.id,
          user_story_id: @user_story.id
        }
      )
      expect(response).to be_successful
    end

    it 'redirect without release' do
      get(
        :new,
        params: {
          project_id: @project.id, release_id: @release.id, user_story_id: 0
        }
      )
      expect(response).to redirect_to(release_path(@project.id, @release.id))
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      @task = create(:task)
      get(
        :edit,
        params: {
          project_id: @project.id,
          release_id: @release.id,
          user_story_id: @user_story.id,
          task_id: @task.id
        }
      )
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Task' do
        expect {
          post(
            :create,
            params: {
              project_id: @project.id,
              release_id: @release.id,
              user_story_id: @user_story.id,
              task: valid_attributes
            }
          )
        }.to change(Task, :count).by(1)
      end

      it 'redirects to the created task' do
        post(
          :create,
          params: {
            project_id: @project.id,
            release_id: @release.id,
            user_story_id: @user_story.id,
            task: valid_attributes
          }
        )
        expect(response).to redirect_to(
          user_story_path(@project.id, @release.id, @user_story.id)
        )
      end
    end

    context 'with invalid params' do
      it 'does not creates a new Task' do
        expect {
          post(
            :create,
            params: {
              project_id: @project.id,
              release_id: @release.id,
              user_story_id: @user_story.id,
              task: invalid_attributes
            }
          )
        }.not_to change(Task, :count)
      end
    end
  end

  describe 'PUT #update' do
    before { @task = create(:task) }

    context 'with valid params' do
      let(:params) do
        {
          project_id: @project.id,
          release_id: @release.id,
          user_story_id: @user_story.id,
          task_id: @task.id,
          task: valid_attributes
        }
      end

      it 'updates the requested task' do
        put(:update, params: params)
        @task.reload
        expect(@task.name).to eq('Second Task')
      end

      it 'redirects to the task' do
        put(:update, params: params)
        expect(response).to redirect_to(
          user_story_path(@project.id, @release.id, @user_story.id)
        )
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          project_id: @project.id,
          release_id: @release.id,
          user_story_id: @user_story.id,
          task_id: @task.id,
          task: invalid_attributes
        }
      end

      it 'does not updates the Task' do
        expect { put(:update, params: params) }.not_to change(Task, :first)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { @task = create(:task) }

    it 'destroys the requested task' do
      expect {
        delete(
          :destroy,
          params: {
            project_id: @project.id,
            release_id: @release.id,
            user_story_id: @user_story.id,
            task_id: @task.id
          }
        )
      }.to change(Task, :count).by(-1)
    end

    it 'redirects to the tasks list' do
      delete(
        :destroy,
        params: {
          project_id: @project.id,
          release_id: @release.id,
          user_story_id: @user_story.id,
          task_id: @task.id
        }
      )
      expect(response).to redirect_to(
        user_story_path(@project.id, @release.id, @user_story.id)
      )
    end
  end
end
