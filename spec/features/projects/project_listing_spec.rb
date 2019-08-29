# frozen_string_literal: true

require 'rails_helper'

feature 'Projects', type: :feature do
  let(:user) { create(:user) }
  let(:project) { create(:project) }

  before do
    login_as(user)
  end

  feature 'list projects' do
    scenario 'user visits projects page' do
      visit(root_path)

      expect(page).to have_selector('h1', text: 'Projects')
      expect(page).to have_link('New Project', href: new_project_path)
    end

    scenario 'user visits projects page with projects' do
      project = create(:project)
      visit(root_path)
      expect(page).to have_link('Neptune', href: project_path(project))
    end
  end
end
