# frozen_string_literal: true

class AcceptTestsController < ApplicationController
  before_action :set_accept_test, only: [:show, :edit, :update, :destroy]
  before_action :user_story, only: [:new]

  # GET /accept_tests
  def index
    @accept_tests = AcceptTest.all
  end

  # GET /accept_tests/1
  def show
  end

  # GET /accept_tests/new
  def new
    @accept_test = AcceptTest.new(user_story: user_story)
  end

  # GET /accept_tests/1/edit
  def edit
  end

  # POST /accept_tests
  def create
    @accept_test = AcceptTest.new(accept_test_params)

    if @accept_test.save
      redirect_to user_story_path(params[:project_id], params[:release_id], params[:user_story_id]), notice: 'Accept test was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /accept_tests/1
  def update
    if @accept_test.update(accept_test_params)
      redirect_to user_story_path(params[:project_id], params[:release_id], params[:user_story_id]), notice: 'Accept test was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /accept_tests/1
  def destroy
    @accept_test.destroy
    redirect_to user_story_path(params[:project_id], params[:release_id], params[:user_story_id]), notice: 'Accept test was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_accept_test
    @accept_test = AcceptTest.find(params[:accept_test_id])
  end

  # Only allow a trusted parameter "white list" through.
  def accept_test_params
    params.require(:accept_test).permit(:name, :description, :user_story_id)
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
