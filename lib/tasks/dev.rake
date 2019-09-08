# frozen_string_literal: true

namespace :dev do
  desc 'Seed data for development'
  task seed: :environment do
    db_config

    user = FactoryBot.create(:user)
    project = Project.create(name: 'Neptune', start_date: Time.zone.today, description: 'Description ...', user: user)

    release0 = Release.create(name: 'Release 0', start_date: (Time.zone.today - 30), finish_date: Time.zone.today, active: false, project: project)
    release0.user_stories << UserStory.new(name: 'US01', description: 'Description', release: release0)
    release0.save

    release1 = Release.create(name: 'Release 1', start_date: (Time.zone.today + 2), finish_date: (Time.zone.today + 31.days), active: true, project: project)
    release1.user_stories = [
      UserStory.new(name: 'US01', description: 'Description', release: release1),
      UserStory.new(name: 'US02', description: 'Description', release: release1)
    ]
    release1.save

    release2 = Release.create(name: 'Release 2', start_date: (Time.zone.today + 3), finish_date: (Time.zone.today + 32.days), active: true, project: project)
    release2.user_stories << UserStory.new(name: 'US01', description: 'Description', release: release2)
    release2.save

    release3 = Release.create(name: 'Release 3', start_date: (Time.zone.today + 4), finish_date: (Time.zone.today + 33.days), active: true, project: project)

    project.releases = [release0, release1, release2, release3]
    project.save
  end

  desc 'Configure Database'
  task db_config: :environment do
    db_config
  end

  desc 'Check code health'
  task check: :environment do
    [:brakeman, :rails_best_practices, :rubycritic].each { |tool| run_tool(tool) }
  end

  def db_config
    puts `rake db:drop`
    puts `rake db:create`
    puts `rake db:migrate`
  end

  def run_tool(tool)
    title = "Running #{tool.to_s.humanize.titleize}..."
    puts "#{title}#{' ' * (`tput cols`.to_i - title.length)}".colorize(:light_white).colorize(background: :blue)
    send(:"run_#{tool}")
    puts
  end

  def run_brakeman
    result = `bundle exec brakeman --quiet --format plain`

    puts build_result_output(result, 'No warnings found')
  end

  def run_rails_best_practices
    result = `rails_best_practices .`

    puts build_result_output(result, 'No warning found. Cool!')
  end

  def run_rubycritic
    result = `rubycritic app config lib`

    puts build_rubycritic_score(result.match(/Score: (?<score>\d+.\d+)/)[:score].to_d)
  end

  def build_result_output(result, message)
    return result unless result.include?(message)

    "#{message} \u{1f60e}".colorize(:light_blue)
  end

  def build_rubycritic_score(score)
    case score
    when 95..100
      "Score: #{score} \u{1f60e}".colorize(:light_blue)
    when 85...95
      "Score: #{score} \u{1f914}".colorize(:light_yellow)
    else
      "Score: #{score} \u{1f922}".colorize(:light_red)
    end
  end
end
