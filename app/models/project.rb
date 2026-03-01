# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id             :bigint           not null, primary key
#  description    :text
#  end_date       :datetime
#  featured       :boolean          default(FALSE), not null
#  featured_order :integer
#  git_link       :string
#  intro          :text
#  name           :string
#  owner_name     :string
#  preview_link   :string
#  slug           :string
#  start_date     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  chapter_id     :bigint           not null
#
# Indexes
#
#  index_projects_on_chapter_id  (chapter_id)
#  index_projects_on_featured    (featured)
#  index_projects_on_slug        (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (chapter_id => chapters.id)
#
class Project < ApplicationRecord
  # Attachments
  has_one_attached :image

  # Associations
  belongs_to :chapter
  has_many :project_contributors, dependent: :destroy
  has_many :contributors, through: :project_contributors, source: :user

  # Callbacks
  before_validation :generate_slug, if: -> { name.present? && (slug.blank? || name_changed?) }

  # Validations
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :intro, length: { maximum: 200 }, allow_blank: true
  validates :preview_link, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), allow_blank: true }
  validates :git_link, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), allow_blank: true }

  # Scopes
  scope :featured, -> { where(featured: true).order(:featured_order, :created_at) }
  scope :not_featured, -> { where(featured: false) }
  scope :search, lambda { |query|
    where('name ILIKE ? OR description ILIKE ? OR intro ILIKE ?',
          "%#{sanitize_sql_like(query)}%",
          "%#{sanitize_sql_like(query)}%",
          "%#{sanitize_sql_like(query)}%")
  }

  # Methods
  def image?
    image.attached?
  end

  def to_param
    slug
  end

  def add_contributor(user, role: 'contributor')
    project_contributors.find_or_create_by(user: user) do |pc|
      pc.role = role
    end
  end

  def remove_contributor(user)
    project_contributors.where(user: user).destroy_all
  end

  private

  def generate_slug
    base_slug = name.parameterize
    candidate_slug = base_slug
    counter = 1

    while Project.where(slug: candidate_slug).where.not(id: id).exists?
      candidate_slug = "#{base_slug}-#{counter}"
      counter += 1
    end

    self.slug = candidate_slug
  end
end
