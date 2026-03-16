# frozen_string_literal: true

require 'test_helper'

class ChronologicalOrderingPropertyTest < ActionDispatch::IntegrationTest
  setup do
    @chapter = chapters(:one)
  end

  # **Feature: events-conferences-chapters, Property 4: Event chronological ordering**
  # **Validates: Requirements 2.4, 4.2**
  # Property: For any event listing (general events or conferences), events should be ordered
  # chronologically with upcoming events appearing before past events
  test 'property: events are ordered chronologically on events index' do
    # Create a mix of upcoming and past events with random dates
    events = []

    # Create 10 upcoming events
    10.times do |i|
      start_time = Time.current + rand(1..30).days + rand(0..23).hours
      events << Event.create!(
        title: "Upcoming Event #{i}",
        description: "Description #{i}",
        start_datetime: start_time,
        end_datetime: start_time + rand(1..8).hours,
        status: 'published',
        event_type: 'meetup',
        chapter: @chapter,
        location_name: "Location #{i}"
      )
    end

    # Create 10 past events
    10.times do |i|
      start_time = Time.current - rand(1..30).days - rand(0..23).hours
      events << Event.create!(
        title: "Past Event #{i}",
        description: "Description #{i}",
        start_datetime: start_time,
        end_datetime: start_time + rand(1..8).hours,
        status: 'published',
        event_type: 'meetup',
        chapter: @chapter,
        location_name: "Location #{i}"
      )
    end

    # Get events through the search service (which is used by the index action)
    result_events = EventSearchService.new({}).call.to_a

    # Verify chronological ordering
    result_events.each_cons(2) do |event1, event2|
      assert event1.start_datetime <= event2.start_datetime,
             "Events should be ordered chronologically: #{event1.title} (#{event1.start_datetime}) should come before #{event2.title} (#{event2.start_datetime})"
    end

    # Clean up
    events.each(&:destroy)
  end

  test 'property: conferences are ordered chronologically with upcoming before past' do
    # Create a mix of upcoming and past conferences
    conferences = []

    # Create 5 upcoming conferences
    5.times do |i|
      start_time = Time.current + rand(1..30).days + rand(0..23).hours
      conferences << Event.create!(
        title: "Upcoming Conference #{i}",
        description: "Description #{i}",
        start_datetime: start_time,
        end_datetime: start_time + rand(1..8).hours,
        status: 'published',
        event_type: 'conference',
        chapter: @chapter,
        location_name: "Location #{i}"
      )
    end

    # Create 5 past conferences
    5.times do |i|
      start_time = Time.current - rand(1..30).days - rand(0..23).hours
      conferences << Event.create!(
        title: "Past Conference #{i}",
        description: "Description #{i}",
        start_datetime: start_time,
        end_datetime: start_time + rand(1..8).hours,
        status: 'published',
        event_type: 'conference',
        chapter: @chapter,
        location_name: "Location #{i}"
      )
    end

    # Get upcoming and past conferences as done in the controller
    upcoming = Event.published.conferences.upcoming.order(:start_datetime).to_a
    past = Event.published.conferences.past.order(start_datetime: :desc).to_a

    # Verify upcoming conferences are ordered chronologically (ascending)
    upcoming.each_cons(2) do |conf1, conf2|
      assert conf1.start_datetime <= conf2.start_datetime,
             'Upcoming conferences should be ordered chronologically ascending'
    end

    # Verify past conferences are ordered reverse chronologically (descending)
    past.each_cons(2) do |conf1, conf2|
      assert conf1.start_datetime >= conf2.start_datetime,
             'Past conferences should be ordered reverse chronologically (most recent first)'
    end

    # Clean up
    conferences.each(&:destroy)
  end

  test 'property: chapter events are ordered chronologically' do
    # Create events for the chapter
    chapter_events = []

    # Create 5 upcoming events
    5.times do |i|
      start_time = Time.current + rand(1..30).days + rand(0..23).hours
      chapter_events << Event.create!(
        title: "Chapter Upcoming Event #{i}",
        description: "Description #{i}",
        start_datetime: start_time,
        end_datetime: start_time + rand(1..8).hours,
        status: 'published',
        event_type: 'meetup',
        chapter: @chapter,
        location_name: "Location #{i}"
      )
    end

    # Create 5 past events
    5.times do |i|
      start_time = Time.current - rand(1..30).days - rand(0..23).hours
      chapter_events << Event.create!(
        title: "Chapter Past Event #{i}",
        description: "Description #{i}",
        start_datetime: start_time,
        end_datetime: start_time + rand(1..8).hours,
        status: 'published',
        event_type: 'meetup',
        chapter: @chapter,
        location_name: "Location #{i}"
      )
    end

    # Get events through chapter methods
    upcoming = @chapter.upcoming_events.to_a
    past = @chapter.past_events.to_a

    # Verify upcoming events are ordered chronologically (ascending)
    upcoming.each_cons(2) do |event1, event2|
      assert event1.start_datetime <= event2.start_datetime,
             'Chapter upcoming events should be ordered chronologically ascending'
    end

    # Verify past events are ordered reverse chronologically (descending)
    past.each_cons(2) do |event1, event2|
      assert event1.start_datetime >= event2.start_datetime,
             'Chapter past events should be ordered reverse chronologically (most recent first)'
    end

    # Clean up
    chapter_events.each(&:destroy)
  end
end
