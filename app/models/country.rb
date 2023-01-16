class Country < ApplicationRecord
  # Callbacks
  after_create_commit -> {
    broadcast_prepend_to 'countries', partial: 'countries/new_country', locals: { country: self },
                         target: 'countries' }

  after_update_commit -> { broadcast_update_to 'countries', partial: 'countries/new_country',
                                               locals: { country: self }, target: self }

  after_destroy_commit -> { broadcast_remove_to 'countries', target: self }

  # Validations
  validates :name, presence: true

  def update_countries
    broadcast_prepend_to 'countries', partial: 'countries/new_country', locals: { country: self },
                         target: 'countries'
  end
end
