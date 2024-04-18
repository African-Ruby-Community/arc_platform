# frozen_string_literal: true

class LearningMaterial < ApplicationRecord
  # Associations
  belongs_to :user
  has_one_attached :thumbnail

  # Enum
  enum tag: { beginners: 0, intermediates: 1, experts: 2 }

  # Validations
  validates :tag, :learning_material_title, :learning_material_description, :learning_material_link, presence: true
  validates :learning_material_link,
            format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: :invalid_url }
end
