# frozen_string_literal: true

class Event < ApplicationRecord
  # Associations
  belongs_to :chapter
  has_many :speakers, dependent: :destroy
  has_one_attached :image

  accepts_nested_attributes_for :speakers, allow_destroy: true, reject_if: :all_blank

  # Geocoding - automatically gets lat/lng from location_name
  geocoded_by :location_name
  # Callbacks
  before_validation :generate_slug, on: :create
  after_validation :geocode, if: ->(obj) { obj.location_name.present? && obj.location_name_changed? }

  # Validations
  validates :title, :description, :start_datetime, :end_datetime, :status, :event_type, presence: true
  validates :status, inclusion: { in: %w[draft published archived] }
  validates :event_type, inclusion: { in: %w[meetup conference workshop] }
  validates :payment_status, inclusion: { in: %w[free paid] }
  validates :slug, presence: true, uniqueness: true
  validate :end_datetime_after_start_datetime

  # Scopes
  scope :published, -> { where(status: 'published') }
  scope :conferences, -> { where(event_type: 'conference') }
  scope :upcoming, -> { where('start_datetime > ?', Time.current) }
  scope :past, -> { where(start_datetime: ...Time.current) }

  # Override to_param to use slug in URLs
  def to_param
    slug
  end

  # Check if event has coordinates for map display
  def mappable?
    latitude.present? && longitude.present?
  end

  private

  def generate_slug
    return if slug.present? || title.blank?

    base_slug = title.parameterize
    candidate_slug = base_slug
    counter = 1

    while Event.exists?(slug: candidate_slug)
      candidate_slug = "#{base_slug}-#{counter}"
      counter += 1
    end

    self.slug = candidate_slug
  end

  def end_datetime_after_start_datetime
    return if end_datetime.blank? || start_datetime.blank?

    return unless end_datetime < start_datetime

    errors.add(:end_datetime, 'must be after start datetime')
  end
end
