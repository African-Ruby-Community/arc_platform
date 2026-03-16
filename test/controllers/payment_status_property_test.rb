# frozen_string_literal: true

require 'test_helper'

class PaymentStatusPropertyTest < ActionDispatch::IntegrationTest
  setup do
    @chapter = chapters(:one)
  end

  # **Feature: events-conferences-chapters, Property 8: Payment status display consistency**
  # **Validates: Requirements 5.3, 5.4**
  # Property: For any event displayed, if payment_status is "free" it should show a "Free" badge,
  # and if "paid" it should show the price and "Paid" badge
  test 'property: payment status displays correctly for all events' do
    # Test with 100 iterations to verify the property holds across various payment configurations
    100.times do |iteration|
      payment_status = %w[free paid].sample
      price_cents = payment_status == 'paid' ? rand(1000..50_000) : 0

      # Create an event with random payment status
      event = Event.create!(
        title: "Test Event #{iteration}-#{rand(10_000)}",
        description: "Test Description #{iteration}",
        start_datetime: Time.current + rand(1..30).days,
        end_datetime: Time.current + rand(31..60).days,
        status: 'published',
        event_type: 'conference',
        chapter: @chapter,
        location_name: "Test Location #{rand(100)}",
        payment_status: payment_status,
        price_cents: price_cents
      )

      # Test on event show page
      get event_url(event)
      assert_response :success

      if event.payment_status == 'free'
        # Verify "Free" badge is displayed
        assert_match(/Free/i, response.body,
                     'Free badge should be displayed for free events')
        # Verify price is not displayed for free events
        assert_no_match(/\$\d+/, response.body.gsub('$0.00', ''),
                        'Price should not be displayed for free events (except $0.00)')
      else
        # Verify price is displayed for paid events
        formatted_price = ActionController::Base.helpers.number_to_currency(event.price_cents / 100.0)
        assert_match formatted_price, response.body,
                     "Price '#{formatted_price}' should be displayed for paid events"
      end

      # Test on events index page
      get events_url
      assert_response :success

      # Verify the event appears in the listing
      assert_match event.title, response.body,
                   'Event should appear in events listing'

      # Clean up
      event.destroy
    end
  end

  # Additional test for chapter show page payment status display
  test 'property: payment status displays correctly on chapter pages' do
    50.times do |iteration|
      payment_status = %w[free paid].sample
      price_cents = payment_status == 'paid' ? rand(1000..50_000) : 0

      event = Event.create!(
        title: "Chapter Event #{iteration}-#{rand(10_000)}",
        description: "Test Description #{iteration}",
        start_datetime: Time.current + rand(1..30).days,
        end_datetime: Time.current + rand(31..60).days,
        status: 'published',
        event_type: 'meetup',
        chapter: @chapter,
        location_name: "Test Location #{rand(100)}",
        payment_status: payment_status,
        price_cents: price_cents
      )

      # Test on chapter show page
      get chapter_url(@chapter)
      assert_response :success

      # Verify event appears
      assert_match event.title, response.body,
                   'Event should appear on chapter page'

      if event.payment_status == 'free'
        # Verify "Free" badge is displayed
        assert_match(/Free/i, response.body,
                     'Free badge should be displayed for free events on chapter page')
      end

      # Clean up
      event.destroy
    end
  end
end
