# frozen_string_literal: true

require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
  setup do
    @project = projects(:one)
  end

  test 'visiting the index' do
    visit projects_url
    assert_selector 'h1', text: 'Projects'
  end

  test 'should show project details' do
    visit project_url(@project)
    assert_selector 'h1', text: @project.name
  end

  test 'should search projects' do
    visit projects_url
    fill_in 'query', with: @project.name
    click_on '🔍'
    assert_text @project.name
  end
end
