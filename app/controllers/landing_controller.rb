# frozen_string_literal: true

class LandingController < ApplicationController
  # People should not require authentication for following actions
  skip_before_action :authenticate_user!, only: %i[index about activities learn]
  def index; end

  ##
  # About us page
  def about; end

  ##
  # Activities page
  def activities; end

  ##
  # Featured learning materials
  def learn; end
end
