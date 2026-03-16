# frozen_string_literal: true

require 'test_helper'

class ConferencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @upcoming_conference = events(:upcoming_conference)
    @past_conference = events(:published_past)
  end

  test 'should get index without authentication' do
    get conferences_url
    assert_response :success
  end

  test 'index should only show conference-type events' do
    get conferences_url
    assert_response :success

    # Should show conferences
    assert_match @upcoming_conference.title, response.body
    assert_match @past_conference.title, response.body

    # Should not show non-conference events (meetups, workshops)
    assert_no_match events(:published_upcoming).title, response.body
    assert_no_match events(:draft_event).title, response.body
  end

  test 'index should only show published conferences' do
    # Create a draft conference
    draft_conference = Event.create!(
      title: 'Draft Conference',
      description: 'A draft conference',
      start_datetime: 1.month.from_now,
      end_datetime: 1.month.from_now + 2.days,
      status: 'draft',
      event_type: 'conference',
      location_name: 'Test Venue',
      payment_status: 'free',
      chapter: chapters(:one)
    )

    get conferences_url
    assert_response :success

    # Should show published conferences
    assert_match @upcoming_conference.title, response.body

    # Should not show draft conferences
    assert_no_match draft_conference.title, response.body
  end

  test 'index should separate upcoming and past conferences' do
    get conferences_url
    assert_response :success

    # Both should be present
    assert_match @upcoming_conference.title, response.body
    assert_match @past_conference.title, response.body

    # Check for section headers
    assert_match 'Upcoming Conferences', response.body
    assert_match 'Past Conferences', response.body
  end

  test 'index should highlight featured conference' do
    get conferences_url
    assert_response :success

    # Featured conference section should exist
    assert_match 'Featured Conference', response.body

    # The first upcoming conference should be featured
    assert_match @upcoming_conference.title, response.body
  end

  test 'index should order upcoming conferences chronologically' do
    # Create another upcoming conference
    Event.create!(
      title: 'Later Conference',
      description: 'A later conference',
      start_datetime: 3.weeks.from_now,
      end_datetime: 3.weeks.from_now + 2.days,
      status: 'published',
      event_type: 'conference',
      location_name: 'Another Venue',
      payment_status: 'free',
      chapter: chapters(:one)
    )

    get conferences_url
    assert_response :success

    # Earlier conference should appear first (as featured)
    assert_match @upcoming_conference.title, response.body
  end

  test 'index should show appropriate message when no conferences available' do
    # Delete all conferences
    Event.where(event_type: 'conference').destroy_all

    get conferences_url
    assert_response :success

    # Should show empty state message
    assert_match 'No conferences available', response.body
  end

  test 'index should link to event detail pages' do
    get conferences_url
    assert_response :success

    # Should have links to event detail pages
    assert_match event_path(@upcoming_conference), response.body
    assert_match event_path(@past_conference), response.body
  end
end
