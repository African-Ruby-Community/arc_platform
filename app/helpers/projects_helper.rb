# frozen_string_literal: true

module ProjectsHelper
  def project_image(project, css_class: '')
    if project.image.attached?
      image_tag project.image, alt: project.name, class: css_class
    else
      image_tag "https://placehold.co/600x400?text=#{CGI.escape(project.name)}",
                alt: project.name,
                class: css_class
    end
  end
end
