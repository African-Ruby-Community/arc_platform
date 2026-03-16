# frozen_string_literal: true

class EventSearchService
  def initialize(params = {})
    @query = params[:query]
    @location = params[:location]
    @date_filter = params[:date]
    @country = params[:country]
    @event_type = params[:event_type]
  end

  def call
    events = Event.published.includes(:chapter, :speakers)
    events = filter_by_query(events) if @query.present?
    events = filter_by_location(events) if @location.present?
    events = filter_by_date(events) if @date_filter.present?
    events = filter_by_type(events) if @event_type.present?
    events = filter_by_country(events) if @country.present?
    events.order(:start_datetime)
  end

  private

  def filter_by_query(events)
    events.where('title ILIKE ? OR description ILIKE ?', "%#{@query}%", "%#{@query}%")
  end

  def filter_by_location(events)
    # Search across event location name, chapter location (city), and chapter country name
    events
      .left_joins(chapter: :country)
      .where(
        'events.location_name ILIKE :q OR chapters.location ILIKE :q OR countries.name ILIKE :q',
        q: "%#{@location}%"
      )
  end

  def filter_by_date(events)
    case @date_filter
    when 'today'
      events.where('DATE(start_datetime) = ?', Date.current)
    when 'this_week'
      events.where(start_datetime: Date.current.all_week)
    when 'this_month'
      events.where(start_datetime: Date.current.all_month)
    when 'upcoming'
      events.upcoming
    when 'past'
      events.past
    else
      events
    end
  end

  def filter_by_country(events)
    events.left_joins(chapter: :country)
          .where('countries.name ILIKE :q OR countries.id::text = :exact', q: "%#{@country}%", exact: @country)
  end

  def filter_by_type(events)
    events.where(event_type: @event_type)
  end
end
