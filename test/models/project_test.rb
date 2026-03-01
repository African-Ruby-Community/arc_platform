# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  description :text
#  end_date    :datetime
#  name        :string
#  start_date  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  chapter_id  :bigint           not null
#
# Indexes
#
#  index_projects_on_chapter_id  (chapter_id)
#
# Foreign Keys
#
#  fk_rails_...  (chapter_id => chapters.id)
#
require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test 'should generate slug from name on create' do
    project = Project.new(name: 'My Awesome Project', chapter: chapters(:one))
    assert project.valid?
    assert_equal 'my-awesome-project', project.slug
  end

  test 'should generate unique slug when duplicate exists' do
    Project.create!(name: 'Test Project', slug: 'test-project', chapter: chapters(:one))
    project = Project.new(name: 'Test Project', chapter: chapters(:two))
    assert project.valid?
    assert_equal 'test-project-1', project.slug
  end

  test 'should update slug when name changes' do
    project = projects(:one)
    project.update(name: 'New Project Name')
    assert_equal 'new-project-name', project.slug
  end

  test 'to_param should return slug' do
    project = projects(:one)
    assert_equal project.slug, project.to_param
  end

  test 'should have contributors' do
    project = projects(:one)
    assert project.contributors.any?
    assert_includes project.contributors, users(:organization_admin)
  end

  test 'should allow adding contributors' do
    project = projects(:one)
    user = users(:member)
    project.contributors << user unless project.contributors.include?(user)
    assert_includes project.contributors, user
  end
end
