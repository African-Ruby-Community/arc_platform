# frozen_string_literal: true

class ChaptersController < ApplicationController
  include ActiveStorage::SetCurrent

  before_action :set_chapter, only: %i[show]
  skip_before_action :authenticate_user!, only: %i[index show]

  # GET /chapters or /chapters.json
  def index
    @countries = Country.joins(:chapters).distinct.order(:name)
    @country_param = determine_country_param
    @chapters = filter_chapters_by_country
    load_country_data if @country_param
  end

  # GET /chapters/1 or /chapters/1.json
  def show
    @upcoming_events = @chapter.upcoming_events
    @past_events = @chapter.past_events
    @featured_projects = @chapter.projects.featured.to_a
    @member_count = @chapter.member_count
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chapter
    @chapter = Chapter.find(params[:id])
  end

  def determine_country_param
    kenya = Country.find_by(name: 'Kenya')
    params[:country].presence || kenya&.id&.to_s
  end

  def filter_chapters_by_country
    chapters = Chapter.all
    @country_param ? chapters.where(country_id: @country_param) : chapters
  end

  def load_country_data
    @featured_members = load_featured_members
    @upcoming_events = load_upcoming_events
  end

  def load_featured_members
    User
      .joins(:chapters)
      .where(chapters: { country_id: @country_param })
      .distinct
      .limit(3)
  end

  def load_upcoming_events
    Event
      .published
      .upcoming
      .joins(:chapter)
      .where(chapters: { country_id: @country_param })
      .order(:start_datetime)
  end
end
