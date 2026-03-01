# frozen_string_literal: true

require 'application_system_test_case'

class LearningMaterialsTest < ApplicationSystemTestCase
  test 'view learning materials index with search and filter' do
    LearningMaterial.create!(title: 'Ruby Basics', level: :beginner, link: 'https://ruby-lang.org',
                             thumbnail: 'https://example.com/a.png')
    LearningMaterial.create!(title: 'Rails Advanced', level: :expert, link: 'https://rubyonrails.org',
                             thumbnail: 'https://example.com/b.png', featured: true)

    visit learning_materials_path

    assert_selector 'h1', text: 'Learning Materials'

    fill_in 'q', with: 'Rails'
    select 'Expert', from: 'level'
    click_on 'Search'

    assert_text 'Rails Advanced'
    assert_no_text 'Ruby Basics'
  end
end
