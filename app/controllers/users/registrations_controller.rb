##
# Devise override Registration controller
class Users::RegistrationsController < Devise::RegistrationsController
  ##
  # Devise override Registration create action
  def create
    super do
      if resource.persisted?
        resource.users_chapters.create(chapter_id: params[:chapter_id], main_chapter: true)
      end
    end
  end
end
