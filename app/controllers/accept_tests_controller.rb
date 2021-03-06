# frozen_string_literal: true

class AcceptTestsController < ApplicationController
  include UserStoryActivities

  before_action :set_accept_test, only: [:edit, :update, :destroy]
  before_action :user_story, only: [:new]

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
      redirect_to_user_story('Accept test was successfully created.')
    else
      render :new
    end
  end

  # PATCH/PUT /accept_tests/1
  def update
    if @accept_test.update(accept_test_params)
      redirect_to_user_story('Accept test was successfully updated.')
    else
      render :edit
    end
  end

  # DELETE /accept_tests/1
  def destroy
    @accept_test.destroy
    redirect_to_user_story('Accept test was successfully destroyed.')
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
end
