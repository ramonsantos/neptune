# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AcceptTestsController, type: :routing do
  ACCEPT_TEST_BASE_URL = '/projects/1/releases/2/user_stories/3/accept_tests'

  describe 'routing' do
    it 'routes to #new' do
      expect(get: "#{ACCEPT_TEST_BASE_URL}/new").to route_to('accept_tests#new', project_id: '1', release_id: '2', user_story_id: '3')
    end

    it 'routes to #edit' do
      expect(get: "#{ACCEPT_TEST_BASE_URL}/4/edit").to route_to('accept_tests#edit', project_id: '1', release_id: '2', user_story_id: '3', accept_test_id: '4')
    end

    it 'routes to #create' do
      expect(post: ACCEPT_TEST_BASE_URL).to route_to('accept_tests#create', project_id: '1', release_id: '2', user_story_id: '3')
    end

    it 'routes to #update via PUT' do
      expect(put: "#{ACCEPT_TEST_BASE_URL}/4").to route_to('accept_tests#update', project_id: '1', release_id: '2', user_story_id: '3', accept_test_id: '4')
    end

    it 'routes to #update via PATCH' do
      expect(patch: "#{ACCEPT_TEST_BASE_URL}/4").to route_to('accept_tests#update', project_id: '1', release_id: '2', user_story_id: '3', accept_test_id: '4')
    end

    it 'routes to #destroy' do
      expect(delete: "#{ACCEPT_TEST_BASE_URL}/4").to route_to('accept_tests#destroy', project_id: '1', release_id: '2', user_story_id: '3', accept_test_id: '4')
    end
  end
end
