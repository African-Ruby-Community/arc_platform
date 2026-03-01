# frozen_string_literal: true

module ChaptersHelper
  ACTIVITIES = [
    { image: 'activities_local_meetups.png', title_key: 'activities.meetups' },
    { image: 'activities_local_conferences.png', title_key: 'activities.conferences' },
    { image: 'activities_local_programming.png', title_key: 'activities.programming' },
    { image: 'activities_local_workshops.png', title_key: 'activities.workshops' },
    { image: 'activities_local_hackathons.png', title_key: 'activities.hackathons' }
  ].freeze

  CHAPTERS = [
    { country_key: 'chapters.countries.kenya', image: 'country_kenya.png', alt_key: 'chapters.alt_text.nairuby' },
    { country_key: 'chapters.countries.rwanda', image: 'country_rwanda.png', alt_key: 'chapters.alt_text.arc_rwanda' },
    { country_key: 'chapters.countries.tanzania', image: 'country_tanzania.png',
      alt_key: 'chapters.alt_text.arc_tanzania' },
    { country_key: 'chapters.countries.uganda', image: 'country_uganda.png', alt_key: 'chapters.alt_text.arc_uganda' }
  ].freeze

  FEATURED_SPONSORS = [
    { image: 'sponsors/current/solutech_official.svg', link: 'https://solutech.co.ke',
      alt_key: 'sponsors.current.solutech' },
    { image: 'sponsors/current/app_signal.png', link: 'https://www.appsignal.com',
      alt_key: 'sponsors.current.app_signal' },
    { image: 'sponsors/current/ruby_central.png', link: 'https://rubycentral.org/',
      alt_key: 'sponsors.current.ruby_central' },
    { image: 'sponsors/current/kopo_kopo.png', link: 'https://kopokopo.co.ke', alt_key: 'sponsors.current.kopo_kopo' },
    { image: 'sponsors/current/finplus.png', link: 'https://finplusgroup.com', alt_key: 'sponsors.current.finplus' },
    { image: 'sponsors/current/typesense-logo.png', link: 'https://typesense.org/',
      alt_key: 'sponsors.current.typesense' },
    { image: 'sponsors/current/daystar.png', link: 'https://www.daystar.ac.ke/', alt_key: 'sponsors.current.daystar' },
    { image: 'sponsors/current/prosper.png', link: 'https://www.prosperhedge.com/',
      alt_key: 'sponsors.current.prosper' },
    { image: 'sponsors/current/gurzu.png', link: 'https://gurzu.com/', alt_key: 'sponsors.current.gurzu' },
    { image: 'sponsors/current/must-company.png', link: 'https://must.company/', alt_key: 'sponsors.current.must_company' }
  ].freeze

  PREVIOUS_SPONSORS = [
    { image: 'sponsors/previous/shopify.webp', link: 'https://www.shopify.com/', alt_key: 'sponsors.previous.shopify' },
    { image: 'sponsors/previous/microverse.png', link: 'https://www.microverse.org/',
      alt_key: 'sponsors.previous.microverse' },
    { image: 'sponsors/previous/planet_argon.png', link: 'https://www.planetargon.com',
      alt_key: 'sponsors.previous.planet_argon' },
    { image: 'sponsors/previous/nairobits.png', link: 'https://www.nairobits.com/',
      alt_key: 'sponsors.previous.nairobits' },
    { image: 'sponsors/previous/turing.png', link: 'https://www.turing.com/', alt_key: 'sponsors.previous.turing' },
    { image: 'sponsors/previous/kwara.png', link: 'https://kwara.com/', alt_key: 'sponsors.previous.kwara' },
    { image: 'sponsors/previous/ihub.png', link: 'https://ihub.co.ke/', alt_key: 'sponsors.previous.ihub' },
    { image: 'sponsors/previous/friendly_rb.jpg', link: 'https://friendlyrb.com/',
      alt_key: 'sponsors.previous.friendly_rb' },
    { image: 'sponsors/previous/kca.png', link: 'https://www.kcau.ac.ke', alt_key: 'sponsors.previous.kca' },
    { image: 'sponsors/previous/andela.png', link: 'https://andela.com/', alt_key: 'sponsors.previous.andela' }
  ].freeze

  SOCIALS = [
    { alt_key: 'social_media.twitter', link: 'https://twitter.com/ruby_african', image: 'brands_twitter.png',
      show: true },
    { alt_key: 'social_media.telegram', link: '#', image: 'brands_telegram.png',
      show: FeatureFlag.find_by(name: 'telegram')&.enabled },
    { alt_key: 'social_media.facebook', link: 'https://www.facebook.com/rubycommunity.africa',
      image: 'brands_facebook.png',
      show: true },
    { alt_key: 'social_media.instagram', link: '#', image: 'brands_instagram.png', show: true },
    { alt_key: 'social_media.linkedin', link: 'https://www.linkedin.com/company/african-ruby-community/',
      image: 'brands_linkedin.png', show: true },
    { alt_key: 'social_media.github', link: 'https://github.com/nairuby', image: 'brands_github.png', show: true }
  ].freeze

  def activities
    ACTIVITIES.map do |activity|
      activity.merge(title: I18n.t(activity[:title_key]))
    end
  end

  def chapters
    CHAPTERS
  end

  def featured_sponsors
    FEATURED_SPONSORS.map do |sponsor|
      sponsor.merge(alt: I18n.t(sponsor[:alt_key]))
    end
  end

  def previous_sponsors
    PREVIOUS_SPONSORS.map do |sponsor|
      sponsor.merge(alt: I18n.t(sponsor[:alt_key]))
    end
  end

  def socials
    SOCIALS.map do |social|
      social.merge(alt: I18n.t(social[:alt_key]))
    end
  end
end
