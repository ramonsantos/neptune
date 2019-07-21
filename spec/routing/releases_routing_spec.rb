# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReleasesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/projects/2/releases').to route_to('releases#index', project_id: '2')
    end

    it 'routes to #new' do
      expect(get: '/projects/2/releases/new').to route_to('releases#new', project_id: '2')
    end

    it 'routes to #show' do
      expect(get: '/projects/2/releases/1').to route_to('releases#show', project_id: '2', release_id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/projects/2/releases/1/edit').to route_to('releases#edit', project_id: '2', release_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/projects/2/releases').to route_to('releases#create', project_id: '2')
    end

    it 'routes to #update via PUT' do
      expect(put: '/projects/2/releases/1').to route_to('releases#update', project_id: '2', release_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/projects/2/releases/1').to route_to('releases#update', project_id: '2', release_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/projects/2/releases/1').to route_to('releases#destroy', project_id: '2', release_id: '1')
    end
  end
end
