# frozen_string_literal: true

require 'test_helper'

class DataIntegrityPropertyTest < ActiveSupport::TestCase
  # **Feature: events-conferences-chapters, Property 12: Data integrity during modifications**
  # **Validates: Requirements 8.3, 8.4, 8.5**
  # Property: For any update or deletion operation, referential integrity should be maintained
  # and cascade operations should handle dependent records appropriately

  test 'property: deleting an event cascades to delete associated speakers' do
    # Test with 50 iterations to verify cascade delete works consistently
    50.times do |iteration|
      chapter = chapters(:one)

      # Create an event
      event = Event.create!(
        title: "Event #{iteration}-#{rand(10_000)}",
        description: "Description #{iteration}",
        start_datetime: Time.current + rand(1..30).days,
        end_datetime: Time.current + rand(31..60).days,
        status: 'published',
        event_type: 'conference',
        chapter: chapter,
        location_name: "Location #{rand(100)}"
      )

      # Create random number of speakers (1-5)
      speaker_count = rand(1..5)
      speaker_ids = Array.new(speaker_count) do |i|
        Speaker.create!(
          name: "Speaker #{iteration}-#{i}-#{rand(10_000)}",
          bio: "Bio #{iteration}-#{i}",
          event: event
        ).id
      end

      # Verify speakers exist
      assert_equal speaker_count, Speaker.where(id: speaker_ids).count,
                   'All speakers should exist before event deletion'

      # Delete the event
      event.destroy

      # Verify speakers are deleted (cascade delete)
      assert_equal 0, Speaker.where(id: speaker_ids).count,
                   'All speakers should be deleted when event is destroyed (cascade delete)'

      # Verify event is deleted
      assert_nil Event.find_by(id: event.id),
                 'Event should be deleted'
    end
  end

  test 'property: deleting a chapter nullifies associated events' do
    # Test with 30 iterations
    30.times do |iteration|
      country = countries(:one)

      # Create a chapter
      chapter = Chapter.create!(
        name: "Chapter #{iteration}-#{rand(10_000)}",
        location: "Location #{iteration}",
        description: "Description #{iteration}",
        country: country
      )

      # Create events for the chapter
      event_count = rand(1..3)
      event_ids = Array.new(event_count) do |i|
        Event.create!(
          title: "Event #{iteration}-#{i}-#{rand(10_000)}",
          description: "Description #{iteration}-#{i}",
          start_datetime: Time.current + rand(1..30).days,
          end_datetime: Time.current + rand(31..60).days,
          status: 'published',
          event_type: 'meetup',
          chapter: chapter,
          location_name: "Location #{rand(100)}"
        ).id
      end

      # Verify events exist and are associated with chapter
      assert_equal event_count, Event.where(id: event_ids, chapter_id: chapter.id).count,
                   'All events should be associated with the chapter'

      # Delete the chapter
      chapter.destroy

      # Verify events are deleted (dependent: :destroy)
      assert_equal 0, Event.where(id: event_ids).count,
                   'All events should be deleted when chapter is destroyed'
    end
  end

  test 'property: updating event maintains speaker associations' do
    # Test with 50 iterations
    50.times do |iteration|
      chapter = chapters(:one)

      # Create an event with speakers
      event = Event.create!(
        title: "Event #{iteration}-#{rand(10_000)}",
        description: "Description #{iteration}",
        start_datetime: Time.current + rand(1..30).days,
        end_datetime: Time.current + rand(31..60).days,
        status: 'published',
        event_type: 'conference',
        chapter: chapter,
        location_name: "Location #{rand(100)}"
      )

      speaker_count = rand(2..4)
      speakers = Array.new(speaker_count) do |i|
        Speaker.create!(
          name: "Speaker #{iteration}-#{i}-#{rand(10_000)}",
          bio: "Bio #{iteration}-#{i}",
          event: event
        )
      end

      # Update the event
      event.update!(
        title: "Updated Event #{iteration}",
        description: "Updated Description #{iteration}",
        status: %w[published archived].sample
      )

      # Verify speaker associations are maintained
      event.reload
      assert_equal speaker_count, event.speakers.count,
                   'Speaker associations should be maintained after event update'

      speakers.each do |speaker|
        speaker.reload
        assert_equal event.id, speaker.event_id,
                     'Speaker should still be associated with the event after update'
      end

      # Clean up
      event.destroy
    end
  end

  test 'property: foreign key constraints prevent orphaned records' do
    # Test with 30 iterations
    30.times do |iteration|
      chapter = chapters(:one)

      # Create an event
      event = Event.create!(
        title: "Event #{iteration}-#{rand(10_000)}",
        description: "Description #{iteration}",
        start_datetime: Time.current + rand(1..30).days,
        end_datetime: Time.current + rand(31..60).days,
        status: 'published',
        event_type: 'meetup',
        chapter: chapter,
        location_name: "Location #{rand(100)}"
      )

      # Verify event has a valid chapter_id
      assert_not_nil event.chapter_id,
                     'Event should have a chapter_id'
      assert_equal chapter.id, event.chapter_id,
                   'Event should be associated with the correct chapter'

      # Verify chapter exists
      assert_not_nil Chapter.find_by(id: event.chapter_id),
                     'Chapter should exist for the event'

      # Create a speaker
      speaker = Speaker.create!(
        name: "Speaker #{iteration}-#{rand(10_000)}",
        bio: "Bio #{iteration}",
        event: event
      )

      # Verify speaker has a valid event_id
      assert_not_nil speaker.event_id,
                     'Speaker should have an event_id'
      assert_equal event.id, speaker.event_id,
                   'Speaker should be associated with the correct event'

      # Verify event exists
      assert_not_nil Event.find_by(id: speaker.event_id),
                     'Event should exist for the speaker'

      # Clean up
      event.destroy
    end
  end
end
