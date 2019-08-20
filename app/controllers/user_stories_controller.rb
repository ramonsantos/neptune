# frozen_string_literal: true

class UserStoriesController < ApplicationController
  before_action :set_user_story, only: [:show, :edit, :update, :destroy]
  before_action :release, only: [:new, :show]

  # GET /user_stories/1
  def show
    @accept_tests = AcceptTest.where(user_story_id: @user_story.id)
    @tasks = Task.where(user_story_id: @user_story.id)
    @release
  end

  # GET /user_stories/new
  def new
    @user_story = UserStory.new(release: release)
  end

  # GET /user_stories/1/edit
  def edit
  end

  # POST /user_stories
  def create
    @user_story = UserStory.new(user_story_params)

    if @user_story.save
      redirect_to release_path(params[:project_id], params[:release_id]), notice: 'User story was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /user_stories/1
  def update
    if @user_story.update(user_story_params)
      redirect_to release_path(params[:project_id], params[:release_id]), notice: 'User story was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /user_stories/1
  def destroy
    @user_story.destroy
    redirect_to release_path(params[:project_id], params[:release_id]), notice: 'User story was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_story
    @user_story = UserStory.find(params[:user_story_id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_story_params
    params.require(:user_story).permit(:number, :name, :description, :situation, :release_id)
  end

  def release
    @release ||= find_release
  rescue
    redirect_to project_path(project_id: params[:project_id])
  end

  def find_release
    Release.find(params[:release_id])
  end
end
