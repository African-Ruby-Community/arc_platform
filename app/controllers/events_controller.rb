# frozen_string_literal: true

class EventsController < ApplicationController
  include ActiveStorage::SetCurrent

  before_action :set_event, only: %i[show edit update destroy]
  before_action :authorize_event, only: %i[edit update destroy]
  before_action :authorize_create, only: %i[new create]
  skip_before_action :authenticate_user!, only: %i[index show]

  # GET /events
  def index
    @events = EventSearchService.new(search_params).call
    @countries = Country.order(:name)
    @pagy, @events = pagy(@events)
  end

  # GET /events/1
  def show
    @related_events = Event.published
                           .where(chapter_id: @event.chapter_id)
                           .where.not(id: @event.id)
                           .upcoming
                           .limit(3)
  end

  # GET /events/new
  def new
    @event = Event.new
    @chapters = current_user.organization_admin? ? Chapter.all : current_user.chapters
  end

  # GET /events/1/edit
  def edit
    @chapters = current_user.organization_admin? ? Chapter.all : current_user.chapters
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      @chapters = current_user.organization_admin? ? Chapter.all : current_user.chapters
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      @chapters = current_user.organization_admin? ? Chapter.all : current_user.chapters
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private

  def set_event
    @event = Event.find_by!(slug: params[:id])
  end

  def authorize_event
    case action_name.to_sym
    when :edit
      authorize! :update, @event
    when :update
      authorize! :update, @event
    when :destroy
      authorize! :destroy, @event
    end
  end

  def authorize_create
    authorize! :create, Event
  end

  def event_params
    params.expect(
      event: [:title, :description, :start_datetime, :end_datetime,
              :status, :event_type, :location_name,
              :payment_status, :price_cents, :chapter_id, :image,
              { speakers_attributes: %i[id name bio photo _destroy] }]
    )
  end

  def search_params
    params.permit(:query, :location, :date, :country)
  end
end
