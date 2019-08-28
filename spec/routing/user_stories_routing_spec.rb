# frozen_string_literal: true

require 'rails_helper'

USER_STORY_BASE_URL = '/projects/1/releases/2/user_stories'

RSpec.describe UserStoriesController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: "#{USER_STORY_BASE_URL}/new").to route_to('user_stories#new', project_id: '1', release_id: '2')
    end

    it 'routes to #show' do
      expect(get: "#{USER_STORY_BASE_URL}/1").to route_to('user_stories#show', project_id: '1', release_id: '2', user_story_id: '1')
    end

    it 'routes to #edit' do
      expect(get: "#{USER_STORY_BASE_URL}/1/edit").to route_to('user_stories#edit', project_id: '1', release_id: '2', user_story_id: '1')
    end

    it 'routes to #create' do
      expect(post: USER_STORY_BASE_URL).to route_to('user_stories#create', project_id: '1', release_id: '2')
    end

    it 'routes to #update via PUT' do
      expect(put: "#{USER_STORY_BASE_URL}/1").to route_to('user_stories#update', project_id: '1', release_id: '2', user_story_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: "#{USER_STORY_BASE_URL}/1").to route_to('user_stories#update', project_id: '1', release_id: '2', user_story_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: "#{USER_STORY_BASE_URL}/1").to route_to('user_stories#destroy', project_id: '1', release_id: '2', user_story_id: '1')
    end
  end
end
