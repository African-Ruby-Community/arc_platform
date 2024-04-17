require 'rails_helper'

RSpec.feature "LearningMaterials", type: :feature do
  before :each do
    visit learning_materials_path
  end

  it 'Displays the two main page headers' do
    visit learning_materials_path
    expect(page).to have_content('Featured Materials')
    expect(page).to have_content('Other Resources')
  end

  it 'Display default text if there are no learning materials found' do
    @learningmaterials = []
    expect(page).to have_content('There are no created learning materials yet')
  end
end
