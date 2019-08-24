# frozen_string_literal: true

namespace :dev do
  desc 'Seed data for development'
  task seed: :environment do
    puts `rake db:drop`
    puts `rake db:create`
    puts `rake db:migrate`

    project =
      Project.create(
        name: 'Neptune', start_date: Date.today, description: 'Description ...'
      )

    release0 =
      Release.create(
        name: 'Release 0',
        start_date: (Date.today - 30),
        finish_date: Date.today,
        active: false,
        project: project
      )
    release0.user_stories <<
      UserStory.new(name: 'US01', description: 'Description', release: release0)
    release0.save

    release1 =
      Release.create(
        name: 'Release 1',
        start_date: (Date.today + 2),
        finish_date: (Date.today + 31.days),
        active: true,
        project: project
      )
    release1.user_stories = [
      UserStory.new(
        name: 'US01', description: 'Description', release: release1
      ),
      UserStory.new(name: 'US02', description: 'Description', release: release1)
    ]
    release1.save

    release2 =
      Release.create(
        name: 'Release 2',
        start_date: (Date.today + 3),
        finish_date: (Date.today + 32.days),
        active: true,
        project: project
      )
    release2.user_stories <<
      UserStory.new(name: 'US01', description: 'Description', release: release2)
    release2.save

    release3 =
      Release.create(
        name: 'Release 3',
        start_date: (Date.today + 4),
        finish_date: (Date.today + 33.days),
        active: true,
        project: project
      )

    project.releases = [release0, release1, release2, release3]
    project.save
  end
end
