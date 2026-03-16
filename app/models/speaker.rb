# frozen_string_literal: true

class Speaker < ApplicationRecord
  belongs_to :event
  has_one_attached :photo

  validates :name, :bio, presence: true
end
