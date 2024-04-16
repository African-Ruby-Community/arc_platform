class LearningMaterial < ApplicationRecord
  # Associations
  belongs_to :user
  has_one_attached :thumbnail

  # Enum
  enum tag: { beginners: 0, intermediates: 1, experts: 2 }
end
