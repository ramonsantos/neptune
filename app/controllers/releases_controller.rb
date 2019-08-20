# frozen_string_literal: true

class ReleasesController < ApplicationController
  before_action :set_release, only: [:show, :edit, :update, :destroy]
  before_action :project, only: [:index, :new]

  # GET /projects/:project_id/releases
  def index
    @releases = Release.where(project_id: params[:project_id])
  end

  # GET /projects/:project_id/releases/:release_id
  def show
    @user_stories = @release.user_stories
  end

  # GET /projects/:project_id/releases/new
  def new
    @release = Release.new(project: project)
  end

  # GET /projects/:project_id/releases/:release_id/edit
  def edit
  end

  # POST /projects/:project_id/releases
  def create
    @release = Release.new(release_params)

    if @release.save
      redirect_to release_path(@release.project_id, @release.id), notice: 'Release was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/:project_id/releases/:release_id
  def update
    if @release.update(release_params)
      redirect_to release_path(@release.project_id, @release.id), notice: 'Release was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /projects/:project_id/releases/:release_id
  def destroy
    @release.destroy
    redirect_to project_path(params[:project_id]), notice: 'Release was successfully destroyed.'
  end

  private

  def set_release
    @release = Release.find(params[:release_id])
  end

  def release_params
    params.require(:release).permit(:name, :start_date, :finish_date, :description, :active, :project_id)
  end

  def project
    @project ||= find_project
  rescue
    redirect_to projects_path
  end

  def find_project
    Project.find(params[:project_id])
  end
end
