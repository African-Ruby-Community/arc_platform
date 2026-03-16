# frozen_string_literal: true

class ConferencesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  # GET /conferences
  def index
    # Filter only conference-type events that are published
    @conferences = Event.published.conferences.includes(:chapter, :speakers)

    # Separate upcoming and past conferences
    @upcoming_conferences = @conferences.upcoming.order(:start_datetime)
    @past_conferences = @conferences.past.order(start_datetime: :desc)

    # Featured conference is the first upcoming conference
    @featured_conference = @upcoming_conferences.first
  end
end
