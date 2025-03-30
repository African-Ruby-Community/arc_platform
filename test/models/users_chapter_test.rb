# frozen_string_literal: true

# == Schema Information
#
# Table name: users_chapters
#
#  id           :bigint           not null, primary key
#  main_chapter :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  chapter_id   :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_users_chapters_on_chapter_id  (chapter_id)
#  index_users_chapters_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (chapter_id => chapters.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class UsersChapterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
