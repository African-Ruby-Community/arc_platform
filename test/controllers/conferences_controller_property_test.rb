# frozen_string_literal: true

require 'test_helper'

class ConferencesControllerPropertyTest < ActionDispatch::IntegrationTest
  setup do
    @chapter = chapters(:one)
  end

  # **Feature: events-conferences-chapters, Property 3: Conference type filtering**
  # **Validates: Requirements 4.1**
  # Property: For any conference page request, only events with event_type equal to "conference" should be returned in the results
  test 'property: conferences index only returns conference-type events' do
    # Test with 100 iterations to verify the property holds across various scenarios
    100.times do |iteration|
      # Clean up events from previous iterations to ensure test isolation
      Event.where.not(id: [events(:published_upcoming).id, events(:published_past).id,
                           events(:draft_event).id, events(:archived_event).id,
                           events(:upcoming_conference).id]).destroy_all

      # Generate random events with different types
      event_types = %w[meetup conference workshop]
      statuses = %w[draft published archived]

      # Create a mix of events with random types and statuses
      created_conferences = []
      created_non_conferences = []

      rand(5..15).times do
        event_type = event_types.sample
        status = statuses.sample
        start_time = rand(1..30).days.from_now

        event = Event.create!(
          title: "Test Event #{iteration}-#{rand(10_000)}",
          description: "Test Description #{rand(10_000)}",
          start_datetime: start_time,
          end_datetime: start_time + rand(1..8).hours,
          status: status,
          event_type: event_type,
          location_name: "Test Location #{rand(100)}",
          payment_status: %w[free paid].sample,
          price_cents: rand(0..10_000),
          chapter: @chapter
        )

        if event_type == 'conference' && status == 'published'
          created_conferences << event
        elsif event_type != 'conference'
          created_non_conferences << event
        end
      end

      # Make the request to conferences index
      get conferences_url
      assert_response :success

      # Verify property: Only published conference-type events should be visible
      # Check that all published conferences are in the response
      created_conferences.each do |conference|
        assert_match conference.title, response.body,
                     "Published conference '#{conference.title}' should appear in conferences index"
      end

      # Check that non-conference events are NOT in the response
      created_non_conferences.each do |event|
        # Use word boundaries to ensure exact title matching
        assert_no_match(/\b#{Regexp.escape(event.title)}\b/, response.body,
                        "Non-conference event '#{event.title}' (type: #{event.event_type}) should NOT appear in conferences index")
      end
    end
  end
end
