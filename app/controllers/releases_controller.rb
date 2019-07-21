# frozen_string_literal: true

class ReleasesController < ApplicationController
  before_action :set_release, only: [:show, :edit, :update, :destroy]

  # GET /releases
  def index
    @releases = Release.where(project_id: params[:project_id])
  end

  # GET /releases/1
  def show
  end

  # GET /releases/new
  def new
    @release = Release.new
    @release.project_id = params[:project_id]
  end

  # GET /releases/1/edit
  def edit
  end

  # POST /releases
  def create
    @release = Release.new(release_params)

    if @release.save
      redirect_to release_path(@release.project_id, @release.id), notice: 'Release was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /releases/1
  def update
    if @release.update(release_params)
      redirect_to release_path(@release.project_id, @release.id), notice: 'Release was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /releases/1
  def destroy
    @release.destroy
    redirect_to releases_url, notice: 'Release was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_release
    @release = Release.find(params[:release_id])
  end

  # Only allow a trusted parameter "white list" through.
  def release_params
    params.require(:release).permit(:name, :start_date, :finish_date, :description, :active, :project_id)
  end
end
