# frozen_string_literal: true

require 'test_helper'

class SpeakerTest < ActiveSupport::TestCase
  def setup
    @chapter = chapters(:one)
    @event = Event.create!(
      title: 'Test Event',
      description: 'Test Description',
      start_datetime: 1.day.from_now,
      end_datetime: 2.days.from_now,
      status: 'published',
      event_type: 'conference',
      chapter: @chapter
    )
  end

  test 'should be valid with valid attributes' do
    speaker = Speaker.new(
      name: 'John Doe',
      bio: 'Expert in Ruby on Rails',
      event: @event
    )
    assert speaker.valid?
  end

  test 'should require name' do
    speaker = Speaker.new(bio: 'Expert in Ruby on Rails', event: @event)
    assert_not speaker.valid?
    assert_includes speaker.errors[:name], "can't be blank"
  end

  test 'should require bio' do
    speaker = Speaker.new(name: 'John Doe', event: @event)
    assert_not speaker.valid?
    assert_includes speaker.errors[:bio], "can't be blank"
  end

  test 'should require event association' do
    speaker = Speaker.new(name: 'John Doe', bio: 'Expert in Ruby on Rails')
    assert_not speaker.valid?
    assert_includes speaker.errors[:event], 'must exist'
  end

  test 'should belong to event' do
    speaker = Speaker.create!(
      name: 'John Doe',
      bio: 'Expert in Ruby on Rails',
      event: @event
    )
    assert_equal @event, speaker.event
  end

  test 'should be deleted when event is deleted' do
    speaker = Speaker.create!(
      name: 'John Doe',
      bio: 'Expert in Ruby on Rails',
      event: @event
    )
    speaker_id = speaker.id

    @event.destroy

    assert_nil Speaker.find_by(id: speaker_id)
  end

  test 'should have photo attachment' do
    speaker = Speaker.new(
      name: 'John Doe',
      bio: 'Expert in Ruby on Rails',
      event: @event
    )
    assert_respond_to speaker, :photo
  end

  # **Feature: events-conferences-chapters, Property 2: Foreign key relationship integrity**
  # **Validates: Requirements 6.1, 8.2**
  # Property: For any speaker created in the system, it must be associated with exactly one valid event that exists in the database
  test 'property: speaker must be associated with exactly one valid event' do
    # Test with 50 random speakers to verify the property holds
    50.times do |i|
      # Test case 1: Speaker with valid event should save successfully
      speaker = Speaker.new(
        name: "Speaker #{i}",
        bio: "Bio for speaker #{i} with expertise in #{%w[Ruby Rails JavaScript DevOps].sample}",
        event: @event
      )

      assert speaker.valid?, "Speaker should be valid with a valid event: #{speaker.errors.full_messages}"
      assert speaker.save, 'Speaker should save with a valid event'
      assert_equal @event.id, speaker.event_id, 'Speaker should be associated with the correct event'
      assert_equal @event, speaker.event, 'Speaker should have access to its event'

      # Clean up
      speaker.destroy
    end

    # Test case 2: Speaker without event should be invalid
    speaker_without_event = Speaker.new(
      name: 'Test Speaker',
      bio: 'Test Bio'
    )

    assert_not speaker_without_event.valid?, 'Speaker should be invalid without an event'
    assert_includes speaker_without_event.errors[:event], 'must exist'

    # Test case 3: Speaker cannot be created with non-existent event_id
    speaker_invalid_event = Speaker.new(
      name: 'Test Speaker',
      bio: 'Test Bio',
      event_id: 999_999
    )

    assert_not speaker_invalid_event.valid?, 'Speaker should be invalid with non-existent event_id'
    assert_includes speaker_invalid_event.errors[:event], 'must exist'
  end
end
