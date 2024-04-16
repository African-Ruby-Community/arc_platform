class LearningMaterialsController < ApplicationController
    def index
        @learningmaterials = LearningMaterial.all
    end
end
