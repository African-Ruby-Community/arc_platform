# frozen_string_literal: true

class LearningMaterialsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @learningmaterials = LearningMaterial.all
    @learningmaterials_with_thumbnails = @learningmaterials.select do |learningmaterial|
      learningmaterial.thumbnail.attached?
    end
    @random_learningmaterials = @learningmaterials_with_thumbnails.sample(2)
    @learningmaterials_with_or_without_thumbnails = @learningmaterials - @random_learningmaterials
  end
end
