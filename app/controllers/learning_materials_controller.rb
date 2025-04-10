# frozen_string_literal: true

class LearningMaterialsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @learning_materials = LearningMaterial.includes(:thumbnail_blob).all
    @learning_materials_with_thumbnails = @learning_materials.select do |learning_material|
      learning_material.thumbnail.attached?
    end
    @random_learning_materials = @learning_materials_with_thumbnails.sample(2)
    @learning_materials_with_or_without_thumbnails = @learning_materials - @random_learning_materials
  end
end
