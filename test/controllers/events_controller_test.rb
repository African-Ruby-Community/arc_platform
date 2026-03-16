# frozen_string_literal: true

require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:published_upcoming)
    @chapter = chapters(:one)
    @user = users(:member)
    @admin = users(:organization_admin)
  end

  # Index action tests
  test 'should get index without authentication' do
    get events_url
    assert_response :success
  end

  test 'index should only show published events' do
    get events_url
    assert_response :success
    # Check that published events are in the response
    assert_match @event.title, response.body
    # Check that draft events are not in the response
    assert_no_match events(:draft_event).title, response.body
  end

  test 'index should filter by event type' do
    get events_url, params: { event_type: 'conference' }
    assert_response :success
    assert_match events(:published_past).title, response.body
  end

  test 'index should filter by location' do
    get events_url, params: { location: 'Tech Hub' }
    assert_response :success
    assert_match @event.title, response.body
  end

  test 'index should filter by query' do
    get events_url, params: { query: 'Ruby' }
    assert_response :success
    assert_match @event.title, response.body
  end

  # Show action tests
  test 'should show event without authentication' do
    get event_url(@event)
    assert_response :success
  end

  test 'should show published event details' do
    get event_url(@event)
    assert_response :success
    assert_match @event.title, response.body
    assert_match @event.description, response.body
  end

  # New action tests
  test 'should get new when organization admin' do
    sign_in @admin
    get new_event_url
    assert_response :success
  end

  test 'should not get new when regular user' do
    sign_in @user
    get new_event_url
    assert_redirected_to root_path
  end

  test 'should redirect to sign in when not authenticated for new' do
    get new_event_url
    assert_redirected_to new_user_session_url
  end

  # Create action tests
  test 'should create event when organization admin' do
    sign_in @admin
    assert_difference('Event.count') do
      post events_url, params: {
        event: {
          title: 'New Event',
          description: 'New event description',
          start_datetime: 1.week.from_now,
          end_datetime: 1.week.from_now + 2.hours,
          status: 'draft',
          event_type: 'meetup',
          location_name: 'Test Location',
          payment_status: 'free',
          price_cents: 0,
          chapter_id: @chapter.id
        }
      }
    end
    assert_redirected_to event_url(Event.last)
  end

  test 'should not create event when regular user' do
    sign_in @user
    assert_no_difference('Event.count') do
      post events_url, params: {
        event: {
          title: 'New Event',
          description: 'New event description',
          start_datetime: 1.week.from_now,
          end_datetime: 1.week.from_now + 2.hours,
          status: 'draft',
          event_type: 'meetup',
          location_name: 'Test Location',
          payment_status: 'free',
          price_cents: 0,
          chapter_id: @chapter.id
        }
      }
    end
    assert_redirected_to root_path
  end

  test 'should not create event when not authenticated' do
    assert_no_difference('Event.count') do
      post events_url, params: {
        event: {
          title: 'New Event',
          description: 'New event description',
          start_datetime: 1.week.from_now,
          end_datetime: 1.week.from_now + 2.hours,
          status: 'draft',
          event_type: 'meetup',
          chapter_id: @chapter.id
        }
      }
    end
    assert_redirected_to new_user_session_url
  end

  test 'should not create event with invalid data' do
    sign_in @admin
    assert_no_difference('Event.count') do
      post events_url, params: {
        event: {
          title: '',
          description: '',
          chapter_id: @chapter.id
        }
      }
    end
    assert_response :unprocessable_entity
  end

  # Edit action tests
  test 'should get edit when authorized' do
    sign_in @user
    get edit_event_url(@event)
    assert_response :success
  end

  test 'should not get edit when not authenticated' do
    get edit_event_url(@event)
    assert_redirected_to new_user_session_url
  end

  test 'should not get edit when not authorized' do
    other_user = User.create!(
      email: 'other@example.com',
      name: 'Other User',
      password: 'password',
      confirmed_at: Time.current
    )
    sign_in other_user
    get edit_event_url(@event)
    assert_redirected_to root_path
  end

  # Update action tests
  test 'should update event when authorized' do
    sign_in @user
    patch event_url(@event), params: {
      event: {
        title: 'Updated Title'
      }
    }
    assert_redirected_to event_url(@event)
    @event.reload
    assert_equal 'Updated Title', @event.title
  end

  test 'should not update event when not authenticated' do
    patch event_url(@event), params: {
      event: {
        title: 'Updated Title'
      }
    }
    assert_redirected_to new_user_session_url
  end

  test 'should not update event when not authorized' do
    other_user = User.create!(
      email: 'other2@example.com',
      name: 'Other User 2',
      password: 'password',
      confirmed_at: Time.current
    )
    sign_in other_user
    patch event_url(@event), params: {
      event: {
        title: 'Updated Title'
      }
    }
    assert_redirected_to root_path
  end

  test 'should not update event with invalid data' do
    sign_in @user
    patch event_url(@event), params: {
      event: {
        title: ''
      }
    }
    assert_response :unprocessable_entity
  end

  # Destroy action tests
  test 'should destroy event when authorized' do
    sign_in @user
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end
    assert_redirected_to events_url
  end

  test 'should not destroy event when not authenticated' do
    assert_no_difference('Event.count') do
      delete event_url(@event)
    end
    assert_redirected_to new_user_session_url
  end

  test 'should not destroy event when not authorized' do
    other_user = User.create!(
      email: 'other3@example.com',
      name: 'Other User 3',
      password: 'password',
      confirmed_at: Time.current
    )
    sign_in other_user
    assert_no_difference('Event.count') do
      delete event_url(@event)
    end
    assert_redirected_to root_path
  end

  # Organization admin tests
  test 'organization admin can edit any event' do
    sign_in @admin
    get edit_event_url(@event)
    assert_response :success
  end

  test 'organization admin can update any event' do
    sign_in @admin
    patch event_url(@event), params: {
      event: {
        title: 'Admin Updated Title'
      }
    }
    assert_redirected_to event_url(@event)
    @event.reload
    assert_equal 'Admin Updated Title', @event.title
  end

  test 'organization admin can destroy any event' do
    sign_in @admin
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end
    assert_redirected_to events_url
  end
end
