# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
  before_action :user_story, only: [:new]

  # GET /tasks/new
  def new
    @task = Task.new(user_story: user_story)
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to user_story_path(params[:project_id], params[:release_id], params[:user_story_id]), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to user_story_path(params[:project_id], params[:release_id], params[:user_story_id]), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to user_story_path(params[:project_id], params[:release_id], params[:user_story_id]), notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :user_story_id)
  end

  def user_story
    @user_story ||= find_user_story
  rescue
    redirect_to release_path(project_id: params[:project_id], release_id: params[:release_id])
  end

  def find_user_story
    UserStory.find(params[:user_story_id])
  end
end
