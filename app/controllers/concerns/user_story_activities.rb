# frozen_string_literal: true

module UserStoryActivities
  extend ActiveSupport::Concern

  included do
    before_action :user_story, only: [:new]
  end

  def user_story
    @user_story ||= find_user_story
  rescue
    redirect_to release_path(project_id: params[:project_id], release_id: params[:release_id])
  end

  def find_user_story
    UserStory.find(params[:user_story_id])
  end

  def redirect_to_user_story(message)
    redirect_to user_story_path(params[:project_id], params[:release_id], params[:user_story_id]), notice: message
  end
end
