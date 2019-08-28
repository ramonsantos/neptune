# frozen_string_literal: true

require 'rails_helper'

TASK_BASE_URL = '/projects/1/releases/2/user_stories/3/tasks'

RSpec.describe TasksController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: "#{TASK_BASE_URL}/new").to route_to('tasks#new', project_id: '1', release_id: '2', user_story_id: '3')
    end

    it 'routes to #edit' do
      expect(get: "#{TASK_BASE_URL}/4/edit").to route_to('tasks#edit', project_id: '1', release_id: '2', user_story_id: '3', task_id: '4')
    end

    it 'routes to #create' do
      expect(post: TASK_BASE_URL).to route_to('tasks#create', project_id: '1', release_id: '2', user_story_id: '3')
    end

    it 'routes to #update via PUT' do
      expect(put: "#{TASK_BASE_URL}/4").to route_to('tasks#update', project_id: '1', release_id: '2', user_story_id: '3', task_id: '4')
    end

    it 'routes to #update via PATCH' do
      expect(patch: "#{TASK_BASE_URL}/4").to route_to('tasks#update', project_id: '1', release_id: '2', user_story_id: '3', task_id: '4')
    end

    it 'routes to #destroy' do
      expect(delete: "#{TASK_BASE_URL}/4").to route_to('tasks#destroy', project_id: '1', release_id: '2', user_story_id: '3', task_id: '4')
    end
  end
end
