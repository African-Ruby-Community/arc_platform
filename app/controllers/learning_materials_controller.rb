class LearningMaterialsController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[index show]

    def index
        @learningmaterials = LearningMaterial.all
        @learningmaterials_with_thumbnails = @learningmaterials.select { |learningmaterial| learningmaterial.thumbnail.attached? }
        @random_learningmaterials = @learningmaterials_with_thumbnails.sample(2)
        @learningmaterials_with_or_without_thumbnails = @learningmaterials - @random_learningmaterials
    end   
end
