# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show]
  skip_before_action :authenticate_user!, only: %i[index show]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end
end
