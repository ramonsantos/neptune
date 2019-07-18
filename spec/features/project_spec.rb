# frozen_string_literal: true

require 'rails_helper'

feature 'Projects', type: :feature do
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

  feature 'new project' do
    before { visit(new_project_path) }

    scenario 'user visits new project page' do
      expect(page).to have_selector('h1', text: 'New Project')
      expect(page).to have_link('Back', href: projects_path)
    end

    scenario 'user creates a project' do
      fill_in('Name', with: 'Neptune')
      fill_in('Start date', with: '2019/06/29')
      fill_in('Description', with: 'Description ...')
      click_on('Create Project')

      expect(page).to have_content('Project was successfully created.')
    end

    scenario 'user creates a project without name' do
      fill_in('Name', with: '')
      fill_in('Start date', with: '2019/06/29')
      fill_in('Description', with: 'Description ...')
      click_on('Create Project')

      expect(page).to have_content("Name can't be blank")
    end
  end

  feature 'edit project' do
    before do
      @project = create(:project)
      visit(edit_project_path(@project.id))
    end

    scenario 'user visits edit project page' do
      expect(page).to have_selector('h1', text: 'Editing Project')
      expect(page).to have_link('Show', href: project_path(@project.id))
      expect(page).to have_link('Back', href: projects_path)
    end

    scenario 'user updates a project' do
      fill_in('Name', with: 'Tarkus')
      fill_in('Start date', with: '2018/04/28')
      fill_in('Description', with: ' Service to send e-mail ')
      click_on('Update Project')

      expect(page).to have_content('Project was successfully updated.')
    end

    scenario 'user updates a project without name' do
      fill_in('Name', with: '')
      fill_in('Start date', with: '2019/06/29')
      fill_in('Description', with: 'Description ...')
      click_on('Update Project')

      expect(page).to have_content("Name can't be blank")
    end
  end

  feature 'show project' do
    scenario 'user visits a project page' do
      project = create(:project)
      visit(project_path(project.id))

      expect(page).to have_content(project.name)
      expect(page).to have_content(project.start_date)
      expect(page).to have_content(project.description)
    end
  end

  feature 'delete project' do
    scenario 'user deletes a project' do
      create(:project)
      visit(projects_path)
      find(:xpath, '/html/body/main/table/tbody/tr[1]/td[6]/a').click
      expect(page).to have_content('Project was successfully destroyed.')
    end
  end
end
