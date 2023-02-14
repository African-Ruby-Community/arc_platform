class Chapter < ApplicationRecord
  # Associations
  belongs_to :country
  has_many :projects, dependent: :destroy
  has_many :memberships, dependent: :destroy

  # Callbacks
  after_create_commit -> {
    broadcast_prepend_to 'chapters', partial: 'chapters/chapter',
                         locals: { chapter: self }, target: 'chapters' }
  after_update_commit -> { broadcast_update_to 'chapters', partial: 'chapters/chapter',
                                               locals: { country: self }, target: self }
  after_destroy_commit -> { broadcast_remove_to 'chapters', target: self }

  # Validations
  validates :name, :location, :country_id, :description, presence: true
  validates :name, uniqueness: true
end
