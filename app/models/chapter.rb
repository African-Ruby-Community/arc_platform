# frozen_string_literal: true

# == Schema Information
#
# Table name: chapters
#
#  id          :bigint           not null, primary key
#  description :text
#  location    :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  country_id  :bigint
#
# Indexes
#
#  index_chapters_on_country_id  (country_id)
#  index_chapters_on_name        (name) UNIQUE
#
class Chapter < ApplicationRecord
  # Attachments
  has_one_attached :image

  # Associations
  belongs_to :country
  has_many :projects, dependent: :nullify
  has_many :users_chapters, dependent: :destroy
  has_many :users, through: :users_chapters

  # Validations
  validates :name, :location, :description, presence: true
  validates :name, uniqueness: true

  ##
  # Image validation not working because of 'no implicit conversion of StringIO into String' error
  # validates :image, attached: true, content_type: %i[jpg png jpeg],
  #           dimension: {
  #             width: 400, height: 225,
  #             message: 'is not given between dimension. It should be 400x225',
  #           }
end
