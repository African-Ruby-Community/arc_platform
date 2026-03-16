# frozen_string_literal: true

require 'test_helper'

class SpeakerPropertyTest < ActiveSupport::TestCase
  # **Feature: events-conferences-chapters, Property 10: Speaker association and display**
  # **Validates: Requirements 6.4, 6.3**
  # Property: For any event with speakers, all associated speakers should be displayed with their complete information
  test 'property: speakers are associated with events and display complete information' do
    # Test with 100 iterations to verify the property holds across various speaker configurations
    100.times do |iteration|
      chapter = chapters(:one)

      # Create an event
      event = Event.create!(
        title: "Test Event #{iteration}-#{rand(10_000)}",
        description: "Test Description #{iteration}",
        start_datetime: Time.current + rand(1..30).days,
        end_datetime: Time.current + rand(31..60).days,
        status: 'published',
        event_type: 'conference',
        chapter: chapter,
        location_name: "Test Location #{rand(100)}"
      )

      # Create random number of speakers (1-5)
      speaker_count = rand(1..5)
      speakers = Array.new(speaker_count) do |i|
        Speaker.create!(
          name: "Speaker #{iteration}-#{i}-#{rand(10_000)}",
          bio: "Bio for speaker #{iteration}-#{i} with details #{rand(10_000)}",
          event: event
        )
      end

      # Verify all speakers are associated with the event
      assert_equal speakers.length, event.speakers.count,
                   "Event should have #{speakers.length} speakers"

      # Verify each speaker has complete information
      event.speakers.each do |speaker|
        assert speaker.name.present?, 'Speaker name should be present'
        assert speaker.bio.present?, 'Speaker bio should be present'
        assert_equal event.id, speaker.event_id, 'Speaker should be associated with the event'
      end

      # Verify speakers can be retrieved through the event
      retrieved_speaker_ids = event.speakers.pluck(:id).sort
      expected_speaker_ids = speakers.map(&:id).sort
      assert_equal expected_speaker_ids, retrieved_speaker_ids,
                   'All speakers should be retrievable through event'

      # Verify cascade delete works
      event_id = event.id
      event.destroy
      assert_equal 0, Speaker.where(event_id: event_id).count,
                   'Speakers should be deleted when event is destroyed'
    end
  end
end
