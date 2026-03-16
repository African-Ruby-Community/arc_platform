# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  SOCIALS = [
    { alt_key: 'social_media.twitter', link: 'https://twitter.com/ruby_african', image: 'brands_twitter.png',
      show: true },
    { alt_key: 'social_media.telegram', link: '#', image: 'brands_telegram.png',
      show: FeatureFlag.find_by(name: 'telegram')&.enabled },
    { alt_key: 'social_media.facebook', link: 'https://www.facebook.com/rubycommunity.africa',
      image: 'brands_facebook.png',
      show: true },
    { alt_key: 'social_media.instagram', link: 'https://www.instagram.com/africanruby_community/', image: 'brands_instagram.png', show: true },
    { alt_key: 'social_media.linkedin', link: 'https://www.linkedin.com/company/african-ruby-community/',
      image: 'brands_linkedin.png', show: true },
    { alt_key: 'social_media.github', link: 'https://github.com/nairuby', image: 'brands_github.png', show: true }
  ].freeze

  def socials
    SOCIALS.map do |social|
      social.merge(alt: I18n.t(social[:alt_key]))
    end
  end
end
