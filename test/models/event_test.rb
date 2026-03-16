# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @chapter = chapters(:one)
  end

  # **Feature: events-conferences-chapters, Property 7: Event datetime validation**
  # **Validates: Requirements 1.2**
  # Property: For any event, the end_datetime must be greater than or equal to the start_datetime
  test 'property: end_datetime must be after or equal to start_datetime' do
    # Test with 100 random datetime pairs to verify the property holds
    100.times do
      base_time = Time.current + rand(1..365).days
      start_time = base_time + rand(0..23).hours

      # Test case 1: end_datetime before start_datetime (should be invalid)
      end_time_before = start_time - rand(1..24).hours
      event = Event.new(
        title: "Test Event #{rand(1000)}",
        description: 'Test Description',
        start_datetime: start_time,
        end_datetime: end_time_before,
        status: 'draft',
        event_type: 'meetup',
        chapter: @chapter
      )

      assert_not event.valid?, 'Event should be invalid when end_datetime is before start_datetime'
      assert_includes event.errors[:end_datetime], 'must be after start datetime'

      # Test case 2: end_datetime after start_datetime (should be valid)
      end_time_after = start_time + rand(1..48).hours
      event_valid = Event.new(
        title: "Test Event #{rand(1000)}",
        description: 'Test Description',
        start_datetime: start_time,
        end_datetime: end_time_after,
        status: 'draft',
        event_type: 'meetup',
        chapter: @chapter
      )

      assert event_valid.valid?,
             "Event should be valid when end_datetime is after start_datetime: #{event_valid.errors.full_messages}"
    end
  end

  # Additional validation tests
  test 'requires title' do
    event = Event.new(description: 'Test', start_datetime: Time.current, end_datetime: 1.hour.from_now,
                      status: 'draft', event_type: 'meetup', chapter: @chapter)
    assert_not event.valid?
    assert_includes event.errors[:title], "can't be blank"
  end

  test 'requires description' do
    event = Event.new(title: 'Test', start_datetime: Time.current, end_datetime: 1.hour.from_now,
                      status: 'draft', event_type: 'meetup', chapter: @chapter)
    assert_not event.valid?
    assert_includes event.errors[:description], "can't be blank"
  end

  test 'requires start_datetime' do
    event = Event.new(title: 'Test', description: 'Test', end_datetime: 1.hour.from_now, status: 'draft',
                      event_type: 'meetup', chapter: @chapter)
    assert_not event.valid?
    assert_includes event.errors[:start_datetime], "can't be blank"
  end

  test 'requires end_datetime' do
    event = Event.new(title: 'Test', description: 'Test', start_datetime: Time.current, status: 'draft',
                      event_type: 'meetup', chapter: @chapter)
    assert_not event.valid?
    assert_includes event.errors[:end_datetime], "can't be blank"
  end

  test 'requires status' do
    event = Event.new(title: 'Test', description: 'Test', start_datetime: Time.current,
                      end_datetime: 1.hour.from_now, event_type: 'meetup', chapter: @chapter)
    event.status = nil
    assert_not event.valid?
    assert_includes event.errors[:status], "can't be blank"
  end

  test 'requires event_type' do
    event = Event.new(title: 'Test', description: 'Test', start_datetime: Time.current,
                      end_datetime: 1.hour.from_now, status: 'draft', chapter: @chapter)
    assert_not event.valid?
    assert_includes event.errors[:event_type], "can't be blank"
  end

  test 'validates status inclusion' do
    event = Event.new(title: 'Test', description: 'Test', start_datetime: Time.current,
                      end_datetime: 1.hour.from_now, status: 'invalid', event_type: 'meetup', chapter: @chapter)
    assert_not event.valid?
    assert_includes event.errors[:status], 'is not included in the list'
  end

  test 'validates event_type inclusion' do
    event = Event.new(title: 'Test', description: 'Test', start_datetime: Time.current,
                      end_datetime: 1.hour.from_now, status: 'draft', event_type: 'invalid', chapter: @chapter)
    assert_not event.valid?
    assert_includes event.errors[:event_type], 'is not included in the list'
  end

  test 'validates payment_status inclusion' do
    event = Event.new(title: 'Test', description: 'Test', start_datetime: Time.current,
                      end_datetime: 1.hour.from_now, status: 'draft', event_type: 'meetup', payment_status: 'invalid', chapter: @chapter)
    assert_not event.valid?
    assert_includes event.errors[:payment_status], 'is not included in the list'
  end

  test 'accepts valid status values' do
    %w[draft published archived].each do |status|
      event = Event.new(title: 'Test', description: 'Test', start_datetime: Time.current,
                        end_datetime: 1.hour.from_now, status: status, event_type: 'meetup', chapter: @chapter)
      assert event.valid?, "Should accept status: #{status}"
    end
  end

  test 'accepts valid event_type values' do
    %w[meetup conference workshop].each do |event_type|
      event = Event.new(title: 'Test', description: 'Test', start_datetime: Time.current,
                        end_datetime: 1.hour.from_now, status: 'draft', event_type: event_type, chapter: @chapter)
      assert event.valid?, "Should accept event_type: #{event_type}"
    end
  end

  test 'accepts valid payment_status values' do
    %w[free paid].each do |payment_status|
      event = Event.new(title: 'Test', description: 'Test', start_datetime: Time.current,
                        end_datetime: 1.hour.from_now, status: 'draft', event_type: 'meetup', payment_status: payment_status, chapter: @chapter)
      assert event.valid?, "Should accept payment_status: #{payment_status}"
    end
  end

  # **Feature: events-conferences-chapters, Property 2: Foreign key relationship integrity**
  # **Validates: Requirements 1.1, 8.1**
  # Property: For any event created in the system, it must be associated with exactly one valid chapter that exists in the database
  test 'property: event must be associated with exactly one valid chapter' do
    # Test with 50 random events to verify the property holds
    50.times do |i|
      # Test case 1: Event with valid chapter should save successfully
      event = Event.new(
        title: "Test Event #{i}",
        description: "Test Description #{i}",
        start_datetime: Time.current + rand(1..30).days,
        end_datetime: Time.current + rand(31..60).days,
        status: %w[draft published archived].sample,
        event_type: %w[meetup conference workshop].sample,
        chapter: @chapter
      )

      assert event.valid?, "Event should be valid with a valid chapter: #{event.errors.full_messages}"
      assert event.save, 'Event should save with a valid chapter'
      assert_equal @chapter.id, event.chapter_id, 'Event should be associated with the correct chapter'
      assert_equal @chapter, event.chapter, 'Event should have access to its chapter'

      # Clean up
      event.destroy
    end

    # Test case 2: Event without chapter should be invalid
    event_without_chapter = Event.new(
      title: 'Test Event',
      description: 'Test Description',
      start_datetime: 1.day.from_now,
      end_datetime: 2.days.from_now,
      status: 'draft',
      event_type: 'meetup'
    )

    assert_not event_without_chapter.valid?, 'Event should be invalid without a chapter'
    assert_includes event_without_chapter.errors[:chapter], 'must exist'
  end

  test 'event belongs to chapter' do
    event = Event.create!(
      title: 'Test Event',
      description: 'Test Description',
      start_datetime: 1.hour.from_now,
      end_datetime: 2.hours.from_now,
      status: 'draft',
      event_type: 'meetup',
      chapter: @chapter
    )

    assert_equal @chapter, event.chapter
    assert_equal @chapter.id, event.chapter_id
  end

  test 'event requires chapter' do
    event = Event.new(
      title: 'Test Event',
      description: 'Test Description',
      start_datetime: 1.hour.from_now,
      end_datetime: 2.hours.from_now,
      status: 'draft',
      event_type: 'meetup'
    )

    assert_not event.valid?
    assert_includes event.errors[:chapter], 'must exist'
  end

  test 'event cannot be created with non-existent chapter_id' do
    event = Event.new(
      title: 'Test Event',
      description: 'Test Description',
      start_datetime: 1.hour.from_now,
      end_datetime: 2.hours.from_now,
      status: 'draft',
      event_type: 'meetup',
      chapter_id: 999_999
    )

    assert_not event.valid?
    assert_includes event.errors[:chapter], 'must exist'
  end

  # **Feature: events-conferences-chapters, Property 1: Event status visibility control**
  # **Validates: Requirements 1.3, 1.4, 2.1, 2.3**
  # Property: For any event in the system, the event should appear in public listings if and only if its status is "published"
  test 'property: event visibility is controlled by published status' do
    # Test with 100 random events to verify the property holds
    100.times do |i|
      # Generate random event attributes
      status = %w[draft published archived].sample
      event_type = %w[meetup conference workshop].sample
      start_time = Time.current + rand(1..365).days
      end_time = start_time + rand(1..48).hours

      # Create event with random status
      event = Event.create!(
        title: "Test Event #{i}",
        description: "Test Description #{i}",
        start_datetime: start_time,
        end_datetime: end_time,
        status: status,
        event_type: event_type,
        chapter: @chapter
      )

      # Verify the property: event appears in published scope if and only if status is "published"
      published_events = Event.published

      if status == 'published'
        assert_includes published_events, event,
                        "Event with status '#{status}' should appear in published listings"
      else
        assert_not_includes published_events, event,
                            "Event with status '#{status}' should NOT appear in published listings"
      end

      # Verify through EventSearchService (which uses published scope)
      search_results = EventSearchService.new({}).call

      if status == 'published'
        assert_includes search_results, event,
                        "Event with status '#{status}' should appear in search results"
      else
        assert_not_includes search_results, event,
                            "Event with status '#{status}' should NOT appear in search results"
      end

      # Clean up
      event.destroy
    end
  end
end
