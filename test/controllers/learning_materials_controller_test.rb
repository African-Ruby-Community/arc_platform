# frozen_string_literal: true

require 'test_helper'

class LearningMaterialsControllerTest < ActionDispatch::IntegrationTest
  fixtures :learning_materials

  test 'should get index' do
    get learning_materials_url
    assert_response :success
    assert_select 'h1', text: 'Learning Materials'
    assert_select 'h3', text: learning_materials(:ruby_basics).title
    assert_select 'h3', text: learning_materials(:rails_intermediate).title
    assert_select 'h3', text: learning_materials(:rails_advanced).title
  end

  test 'index applies search' do
    get learning_materials_url, params: { q: 'Rails' }
    assert_response :success
    assert_select 'h3', text: learning_materials(:ruby_basics).title
    assert_select 'h3', text: learning_materials(:rails_intermediate).title, count: 0
    assert_select 'h3', text: learning_materials(:rails_advanced).title, count: 0
  end

  test 'index applies filter by level' do
    get learning_materials_url, params: { level: 'beginner' }
    assert_response :success
    assert_select 'h3', text: learning_materials(:ruby_basics).title
    assert_select 'h3', text: learning_materials(:rails_intermediate).title, count: 0
    assert_select 'h3', text: learning_materials(:rails_advanced).title, count: 0
  end

  test 'index shows featured materials separately' do
    get learning_materials_url
    assert_response :success
    # Featured section
    assert_select 'section h2', text: 'Featured'
    assert_select 'h3', text: learning_materials(:ruby_basics).title
  end

  # test "index paginates materials" do
  #   # Add extra records to force pagination
  #   15.times do |i|
  #     LearningMaterial.create!(
  #       title: "Material #{i}",
  #       level: :beginner,
  #       link: "https://example.com/#{i}"
  #     )
  #   end
  #
  #   get learning_materials_url, params: { page: 1 }
  #   assert_response :success
  #   assert_select "h3", count: 12 # per(12) in controller
  #
  #   get learning_materials_url, params: { page: 2 }
  #   assert_response :success
  #   assert_select "h3", minimum: 1 # remaining ones
  # end
end
