# frozen_string_literal: true

require 'test_helper'

class EventsControllerPropertyTest < ActionDispatch::IntegrationTest
  setup do
    @chapter = chapters(:one)
  end

  # **Feature: events-conferences-chapters, Property 9: Event field completeness**
  # **Validates: Requirements 2.2, 5.5**
  # Property: For any event detail page, all required event information (title, description, date, time, location, cost) should be displayed
  test 'property: event show page displays all required fields' do
    # Test with 100 iterations to verify the property holds across various event configurations
    100.times do |iteration|
      # Generate random event data
      event_types = %w[meetup conference workshop]
      payment_statuses = %w[free paid]

      event_type = event_types.sample
      payment_status = payment_statuses.sample
      start_time = rand(1..30).days.from_now
      end_time = start_time + rand(1..8).hours
      price_cents = payment_status == 'paid' ? rand(1000..50_000) : 0

      # Create a published event with random data
      event = Event.create!(
        title: "Test Event #{iteration}-#{rand(10_000)}",
        description: "Test Description for event #{iteration} with details #{rand(10_000)}",
        start_datetime: start_time,
        end_datetime: end_time,
        status: 'published',
        event_type: event_type,
        location_name: "Test Location #{rand(100)}",
        payment_status: payment_status,
        price_cents: price_cents,
        chapter: @chapter
      )

      # Make the request to event show page
      get event_url(event)
      assert_response :success

      # Verify property: All required fields should be displayed

      # 1. Title should be displayed
      assert_match event.title, response.body,
                   "Event title '#{event.title}' should be displayed on show page"

      # 2. Description should be displayed
      assert_match event.description, response.body,
                   'Event description should be displayed on show page'

      # 3. Date should be displayed (formatted)
      formatted_date = event.start_datetime.strftime('%B %d, %Y')
      assert_match formatted_date, response.body,
                   "Event date '#{formatted_date}' should be displayed on show page"

      # 4. Start time should be displayed
      formatted_start_time = event.start_datetime.strftime('%I:%M %p')
      assert_match formatted_start_time, response.body,
                   "Event start time '#{formatted_start_time}' should be displayed on show page"

      # 5. End time should be displayed
      formatted_end_time = event.end_datetime.strftime('%I:%M %p')
      assert_match formatted_end_time, response.body,
                   "Event end time '#{formatted_end_time}' should be displayed on show page"

      # 6. Location should be displayed
      assert_match event.location_name, response.body,
                   "Event location '#{event.location_name}' should be displayed on show page"

      # 7. Cost information should be displayed
      if event.payment_status == 'free'
        assert_match(/Free/i, response.body,
                     'Free badge should be displayed for free events')
      else
        # For paid events, the price should be displayed
        formatted_price = ActionController::Base.helpers.number_to_currency(event.price_cents / 100.0)
        assert_match formatted_price, response.body,
                     "Event price '#{formatted_price}' should be displayed for paid events"
      end

      # 8. Event type should be displayed
      assert_match event.event_type.titleize, response.body,
                   "Event type '#{event.event_type.titleize}' should be displayed on show page"

      # Clean up the test event
      event.destroy
    end
  end
end
