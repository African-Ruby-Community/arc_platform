class Country < ApplicationRecord
  # Associations
  has_many :chapters

  # Callbacks
  after_create_commit -> {
    broadcast_prepend_to 'countries', partial: 'countries/created_country',
                         locals: { country: self }, target: 'countries' }

  after_update_commit -> { broadcast_update_to 'countries', partial: 'countries/updated_country',
                                               locals: { country: self }, target: self }

  after_destroy_commit -> { broadcast_remove_to 'countries', target: self }

  # Validations
  validates :name, presence: true
end
