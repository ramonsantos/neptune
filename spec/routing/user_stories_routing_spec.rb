# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserStoriesController, type: :routing do
  BASE_URL = '/projects/1/releases/2/user_stories'

  describe 'routing' do
    it 'routes to #new' do
      expect(get: "#{BASE_URL}/new").to route_to('user_stories#new', project_id: '1', release_id: '2')
    end

    it 'routes to #show' do
      expect(get: "#{BASE_URL}/1").to route_to('user_stories#show', project_id: '1', release_id: '2', user_story_id: '1')
    end

    it 'routes to #edit' do
      expect(get: "#{BASE_URL}/1/edit").to route_to('user_stories#edit', project_id: '1', release_id: '2', user_story_id: '1')
    end

    it 'routes to #create' do
      expect(post: BASE_URL).to route_to('user_stories#create', project_id: '1', release_id: '2')
    end

    it 'routes to #update via PUT' do
      expect(put: "#{BASE_URL}/1").to route_to('user_stories#update', project_id: '1', release_id: '2', user_story_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: "#{BASE_URL}/1").to route_to('user_stories#update', project_id: '1', release_id: '2', user_story_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: "#{BASE_URL}/1").to route_to('user_stories#destroy', project_id: '1', release_id: '2', user_story_id: '1')
    end
  end
end
