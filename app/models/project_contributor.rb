# frozen_string_literal: true

class ProjectContributor < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :user_id, uniqueness: { scope: :project_id }
  validates :role, inclusion: { in: %w[creator maintainer contributor], allow_blank: true }
end
