# frozen_string_literal: true

# == Schema Information
#
# Table name: chapters
#
#  id          :bigint           not null, primary key
#  description :text
#  location    :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  country_id  :bigint
#
# Indexes
#
#  index_chapters_on_country_id  (country_id)
#  index_chapters_on_name        (name) UNIQUE
#
require 'test_helper'

class ChapterTest < ActiveSupport::TestCase
  def setup
    @chapter = chapters(:one)
  end

  # **Feature: events-conferences-chapters, Property 6: Chapter event association and display**
  # **Validates: Requirements 3.1, 3.4**
  # Property: For any chapter page displaying events, only events associated with that specific chapter should appear,
  # and they should include complete event information (title, date, time, location)
  test 'property: chapter displays only its own events with complete information' do
    # Create a second chapter for testing isolation
    country = countries(:one)
    other_chapter = Chapter.create!(
      name: "Other Chapter #{rand(1000)}",
      location: 'Other Location',
      description: 'Other Description',
      country: country
    )

    # Test with 50 random scenarios to verify the property holds
    50.times do |i|
      # Create events for the test chapter
      chapter_event_count = rand(1..5)
      chapter_events = []

      chapter_event_count.times do |j|
        event = Event.create!(
          title: "Chapter Event #{i}-#{j}",
          description: "Description for chapter event #{i}-#{j}",
          start_datetime: Time.current + rand(1..30).days + rand(0..23).hours,
          end_datetime: Time.current + rand(31..60).days + rand(0..23).hours,
          status: 'published',
          event_type: %w[meetup conference workshop].sample,
          location_name: "Location #{i}-#{j}",
          chapter: @chapter
        )
        chapter_events << event
      end

      # Create events for the other chapter (should not appear in @chapter's events)
      other_event_count = rand(1..5)
      other_events = []

      other_event_count.times do |j|
        event = Event.create!(
          title: "Other Event #{i}-#{j}",
          description: "Description for other event #{i}-#{j}",
          start_datetime: Time.current + rand(1..30).days + rand(0..23).hours,
          end_datetime: Time.current + rand(31..60).days + rand(0..23).hours,
          status: 'published',
          event_type: %w[meetup conference workshop].sample,
          location_name: "Other Location #{i}-#{j}",
          chapter: other_chapter
        )
        other_events << event
      end

      # Verify that @chapter only returns its own events
      chapter_all_events = @chapter.events.reload

      # All chapter events should be present
      chapter_events.each do |event|
        assert_includes chapter_all_events, event,
                        "Chapter should include its own event: #{event.title}"
      end

      # No other chapter events should be present
      other_events.each do |event|
        assert_not_includes chapter_all_events, event,
                            "Chapter should not include events from other chapters: #{event.title}"
      end

      # Verify complete event information is accessible
      chapter_all_events.each do |event|
        assert_not_nil event.title, 'Event should have a title'
        assert_not_nil event.description, 'Event should have a description'
        assert_not_nil event.start_datetime, 'Event should have a start_datetime'
        assert_not_nil event.end_datetime, 'Event should have an end_datetime'
        assert_not_nil event.location_name, 'Event should have a location_name'
        assert_equal @chapter.id, event.chapter_id, 'Event should be associated with the correct chapter'
      end

      # Clean up events for next iteration
      chapter_events.each(&:destroy)
      other_events.each(&:destroy)
    end

    # Clean up the other chapter
    other_chapter.destroy
  end

  test 'should have many events' do
    assert_respond_to @chapter, :events
  end

  test 'upcoming_events returns only published upcoming events ordered by start_datetime' do
    # Get fixture events
    fixture_upcoming_1 = events(:published_upcoming)
    fixture_upcoming_2 = events(:upcoming_conference)

    # Create test events
    past_event = Event.create!(
      title: 'Past Event',
      description: 'A past event',
      start_datetime: 2.days.ago,
      end_datetime: 1.day.ago,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    upcoming_event_1 = Event.create!(
      title: 'Upcoming Event 1',
      description: 'First upcoming event',
      start_datetime: 2.days.from_now,
      end_datetime: 3.days.from_now,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    upcoming_event_2 = Event.create!(
      title: 'Upcoming Event 2',
      description: 'Second upcoming event',
      start_datetime: 1.day.from_now,
      end_datetime: 2.days.from_now,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    draft_event = Event.create!(
      title: 'Draft Event',
      description: 'A draft event',
      start_datetime: 5.days.from_now,
      end_datetime: 6.days.from_now,
      status: 'draft',
      event_type: 'meetup',
      chapter: @chapter
    )

    upcoming = @chapter.upcoming_events

    # Should only include published upcoming events (including fixtures)
    assert_includes upcoming, upcoming_event_1
    assert_includes upcoming, upcoming_event_2
    assert_includes upcoming, fixture_upcoming_1
    assert_includes upcoming, fixture_upcoming_2
    assert_not_includes upcoming, past_event
    assert_not_includes upcoming, draft_event

    # Should be ordered by start_datetime ascending
    # Order: upcoming_event_2 (1 day), upcoming_event_1 (2 days), fixture_upcoming_1 (1 week), fixture_upcoming_2 (2 weeks)
    assert_equal upcoming_event_2, upcoming.first
    assert_equal upcoming_event_1, upcoming.second
  end

  test 'past_events returns only published past events ordered by start_datetime descending' do
    # Get fixture event
    fixture_past = events(:published_past)

    # Create test events
    past_event_1 = Event.create!(
      title: 'Past Event 1',
      description: 'First past event',
      start_datetime: 3.days.ago,
      end_datetime: 2.days.ago,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    past_event_2 = Event.create!(
      title: 'Past Event 2',
      description: 'Second past event',
      start_datetime: 1.day.ago,
      end_datetime: 1.hour.ago,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    upcoming_event = Event.create!(
      title: 'Upcoming Event',
      description: 'An upcoming event',
      start_datetime: 1.day.from_now,
      end_datetime: 2.days.from_now,
      status: 'published',
      event_type: 'meetup',
      chapter: @chapter
    )

    archived_past_event = Event.create!(
      title: 'Archived Past Event',
      description: 'An archived past event',
      start_datetime: 5.days.ago,
      end_datetime: 4.days.ago,
      status: 'archived',
      event_type: 'meetup',
      chapter: @chapter
    )

    past = @chapter.past_events

    # Should only include published past events (including fixtures)
    assert_includes past, past_event_1
    assert_includes past, past_event_2
    assert_includes past, fixture_past
    assert_not_includes past, upcoming_event
    assert_not_includes past, archived_past_event

    # Should be ordered by start_datetime descending (most recent first)
    # Order: past_event_2 (1 day ago), past_event_1 (3 days ago), fixture_past (1 week ago)
    assert_equal past_event_2, past.first
    assert_equal past_event_1, past.second
  end

  test 'member_count returns the number of users associated with the chapter' do
    # The fixture already has one user associated with chapter one
    initial_count = @chapter.member_count
    assert_equal 1, initial_count

    # Add another user
    user = create_test_user(email: 'newuser@example.com')
    UsersChapter.create!(user: user, chapter: @chapter)

    assert_equal 2, @chapter.member_count
  end

  test 'destroying chapter should destroy associated events' do
    # Create a new chapter without existing projects to avoid constraint issues
    country = countries(:one)
    test_chapter = Chapter.create!(
      name: 'Test Chapter for Deletion',
      location: 'Test Location',
      description: 'Test Description',
      country: country
    )

    Event.create!(
      title: 'Test Event',
      description: 'A test event',
      start_datetime: 1.day.from_now,
      end_datetime: 2.days.from_now,
      status: 'published',
      event_type: 'meetup',
      chapter: test_chapter
    )

    assert_difference('Event.count', -1) do
      test_chapter.destroy
    end
  end
end
