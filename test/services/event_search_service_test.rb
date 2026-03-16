# frozen_string_literal: true

require 'test_helper'

class EventSearchServiceTest < ActiveSupport::TestCase
  def setup
    @chapter = chapters(:one)
  end

  # **Feature: events-conferences-chapters, Property 5: Event search filtering consistency**
  # **Validates: Requirements 2.5**
  # Property: For any search query with filters applied, all returned events should match the specified filter criteria
  test 'property: search results match all specified filter criteria' do
    # Test with 50 random filter combinations to verify the property holds
    50.times do |i|
      # Create a diverse set of test events with random attributes
      events_data = []
      5.times do |j|
        event_type = %w[meetup conference workshop].sample
        location = ["Tech Hub #{rand(1..10)}", "Community Center #{rand(1..10)}", 'Online'].sample
        days_offset = rand(-30..30)
        start_time = Time.current + days_offset.days
        end_time = start_time + rand(1..8).hours

        event = Event.create!(
          title: "#{event_type.capitalize} Event #{i}-#{j}",
          description: "Description for #{event_type} event",
          start_datetime: start_time,
          end_datetime: end_time,
          status: 'published',
          event_type: event_type,
          location_name: location,
          chapter: @chapter
        )
        events_data << event
      end

      # Test case 1: Filter by event_type
      test_event_type = %w[meetup conference workshop].sample
      results = EventSearchService.new(event_type: test_event_type).call

      results.each do |event|
        assert_equal test_event_type, event.event_type,
                     "Event #{event.id} with type '#{event.event_type}' should not appear in results filtered by '#{test_event_type}'"
      end

      # Test case 2: Filter by location
      test_location = 'Tech Hub'
      results = EventSearchService.new(location: test_location).call

      results.each do |event|
        location_match = event.location_name&.include?(test_location) ||
                         event.chapter.location&.include?(test_location)
        assert location_match,
               "Event #{event.id} with location '#{event.location_name}' and chapter location '#{event.chapter.location}' should match filter '#{test_location}'"
      end

      # Test case 3: Filter by query (title or description)
      test_query = 'meetup'
      results = EventSearchService.new(query: test_query).call

      results.each do |event|
        query_match = event.title.downcase.include?(test_query.downcase) ||
                      event.description.downcase.include?(test_query.downcase)
        assert query_match,
               "Event #{event.id} with title '#{event.title}' and description '#{event.description}' should match query '#{test_query}'"
      end

      # Test case 4: Filter by date (upcoming)
      results = EventSearchService.new(date: 'upcoming').call

      results.each do |event|
        assert event.start_datetime > Time.current,
               "Event #{event.id} with start_datetime '#{event.start_datetime}' should be in the future for 'upcoming' filter"
      end

      # Test case 5: Filter by date (past)
      results = EventSearchService.new(date: 'past').call

      results.each do |event|
        assert event.start_datetime < Time.current,
               "Event #{event.id} with start_datetime '#{event.start_datetime}' should be in the past for 'past' filter"
      end

      # Test case 6: Multiple filters combined
      combined_type = 'conference'
      combined_date = 'upcoming'
      results = EventSearchService.new(event_type: combined_type, date: combined_date).call

      results.each do |event|
        assert_equal combined_type, event.event_type,
                     "Event #{event.id} should match event_type filter '#{combined_type}'"
        assert event.start_datetime > Time.current,
               "Event #{event.id} should match date filter '#{combined_date}'"
      end

      # Clean up
      events_data.each(&:destroy)
    end
  end

  # Additional unit tests for specific filter behaviors
  test 'filters by query in title' do
    event = Event.create!(
      title: 'Ruby Meetup',
      description: 'A great event',
      start_datetime: 1.day.from_now,
      end_datetime: 1.day.from_now + 2.hours,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    results = EventSearchService.new(query: 'Ruby').call
    assert_includes results, event

    event.destroy
  end

  test 'filters by query in description' do
    event = Event.create!(
      title: 'Tech Event',
      description: 'Learn about Ruby programming',
      start_datetime: 1.day.from_now,
      end_datetime: 1.day.from_now + 2.hours,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    results = EventSearchService.new(query: 'Ruby').call
    assert_includes results, event

    event.destroy
  end

  test 'filters by event_type' do
    conference = Event.create!(
      title: 'Tech Conference',
      description: 'Annual conference',
      start_datetime: 1.day.from_now,
      end_datetime: 1.day.from_now + 2.hours,
      status: 'published',
      event_type: 'conference',
      chapter: @chapter
    )

    meetup = Event.create!(
      title: 'Tech Meetup',
      description: 'Monthly meetup',
      start_datetime: 1.day.from_now,
      end_datetime: 1.day.from_now + 2.hours,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    results = EventSearchService.new(event_type: 'conference').call
    assert_includes results, conference
    assert_not_includes results, meetup

    conference.destroy
    meetup.destroy
  end

  test 'filters by location in event location_name' do
    event = Event.create!(
      title: 'Tech Event',
      description: 'Great event',
      start_datetime: 1.day.from_now,
      end_datetime: 1.day.from_now + 2.hours,
      status: 'published',
      event_type: 'meetup',
      location_name: 'Tech Hub Downtown',
      chapter: @chapter
    )

    results = EventSearchService.new(location: 'Tech Hub').call
    assert_includes results, event

    event.destroy
  end

  test 'filters by date - upcoming' do
    upcoming_event = Event.create!(
      title: 'Future Event',
      description: 'Happening soon',
      start_datetime: 1.day.from_now,
      end_datetime: 1.day.from_now + 2.hours,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    past_event = Event.create!(
      title: 'Past Event',
      description: 'Already happened',
      start_datetime: 1.day.ago,
      end_datetime: 1.day.ago + 2.hours,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    results = EventSearchService.new(date: 'upcoming').call
    assert_includes results, upcoming_event
    assert_not_includes results, past_event

    upcoming_event.destroy
    past_event.destroy
  end

  test 'filters by date - past' do
    upcoming_event = Event.create!(
      title: 'Future Event',
      description: 'Happening soon',
      start_datetime: 1.day.from_now,
      end_datetime: 1.day.from_now + 2.hours,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    past_event = Event.create!(
      title: 'Past Event',
      description: 'Already happened',
      start_datetime: 1.day.ago,
      end_datetime: 1.day.ago + 2.hours,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    results = EventSearchService.new(date: 'past').call
    assert_not_includes results, upcoming_event
    assert_includes results, past_event

    upcoming_event.destroy
    past_event.destroy
  end

  test 'returns only published events' do
    published_event = Event.create!(
      title: 'Published Event',
      description: 'Visible event',
      start_datetime: 1.day.from_now,
      end_datetime: 1.day.from_now + 2.hours,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    draft_event = Event.create!(
      title: 'Draft Event',
      description: 'Hidden event',
      start_datetime: 1.day.from_now,
      end_datetime: 1.day.from_now + 2.hours,
      status: 'draft',
      event_type: 'meetup',
      chapter: @chapter
    )

    results = EventSearchService.new({}).call
    assert_includes results, published_event
    assert_not_includes results, draft_event

    published_event.destroy
    draft_event.destroy
  end

  test 'orders events by start_datetime' do
    event1 = Event.create!(
      title: 'Event 1',
      description: 'First event',
      start_datetime: 3.days.from_now,
      end_datetime: 3.days.from_now + 2.hours,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    event2 = Event.create!(
      title: 'Event 2',
      description: 'Second event',
      start_datetime: 1.day.from_now,
      end_datetime: 1.day.from_now + 2.hours,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    event3 = Event.create!(
      title: 'Event 3',
      description: 'Third event',
      start_datetime: 2.days.from_now,
      end_datetime: 2.days.from_now + 2.hours,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    results = EventSearchService.new({}).call
    event_ids = results.pluck(:id)

    assert_equal [event2.id, event3.id, event1.id], event_ids & [event1.id, event2.id, event3.id]

    event1.destroy
    event2.destroy
    event3.destroy
  end
end
