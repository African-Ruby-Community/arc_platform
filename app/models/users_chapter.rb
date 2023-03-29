class UsersChapter < ApplicationRecord
  # Associations
  belongs_to :chapter
  belongs_to :user
end
