# frozen_string_literal: true

module ReleasesHelper
  def user_stories_by_situation(situation)
    @user_stories.select { |us| us.situation == situation }
  end
end
