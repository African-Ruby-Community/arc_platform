# frozen_string_literal: true

class LearningMaterialsController < ApplicationController
  sleep 3
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @materials = filter_and_paginate_materials
    @featured_materials = LearningMaterial.featured.limit(2)
  end

  private

  def filter_and_paginate_materials
    @q = params[:q].to_s.strip
    @level = params[:level].to_s.presence
    LearningMaterial.search(@q).by_level(@level).recent_first
  end
end
