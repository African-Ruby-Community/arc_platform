# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
module ChaptersHelper
  ACTIVITIES = [
    { image: 'activities_local_meetups.png', title_key: 'activities.meetups' },
    { image: 'activities_local_conferences.png', title_key: 'activities.conferences' },
    { image: 'activities_local_programming.png', title_key: 'activities.programming' },
    { image: 'activities_local_workshops.png', title_key: 'activities.workshops' },
    { image: 'activities_local_hackathons.png', title_key: 'activities.hackathons' }
  ].freeze

  CHAPTERS = [
    { country_key: 'chapters.countries.kenya', image: 'countries/country_kenya.png', alt_key: 'chapters.alt_text.nairuby' },
    { country_key: 'chapters.countries.rwanda', image: 'countries/country_rwanda.png', alt_key: 'chapters.alt_text.arc_rwanda' },
    { country_key: 'chapters.countries.tanzania', image: 'countries/country_tanzania.png',
      alt_key: 'chapters.alt_text.arc_tanzania' },
    { country_key: 'chapters.countries.uganda', image: 'countries/country_uganda.png', alt_key: 'chapters.alt_text.arc_uganda' }
  ].freeze

  FEATURED_SPONSORS = [

    { image: 'sponsors/current/kopo_kopo.png', link: 'https://kopokopo.co.ke', alt_key: 'sponsors.current.kopo_kopo' },

    { image: 'sponsors/current/typesense-logo.png', link: 'https://typesense.org/',
      alt_key: 'sponsors.current.typesense' },
    { image: 'sponsors/current/sidekiq.png', link: 'https://sidekiq.org/',
      alt_key: 'sponsors.current.sidekiq' },
    { image: 'sponsors/current/finplus.png', link: 'https://finplusgroup.com', alt_key: 'sponsors.current.finplus' },
    { image: 'sponsors/current/senga.png', link: 'https://senga.co/',
      alt_key: 'sponsors.current.senga' },
    { image: 'sponsors/current/easyqna.jpeg', link: 'https://www.biztimamtechnologies.com/',
      alt_key: 'sponsors.current.easyqna' },
    { image: 'sponsors/current/remiapp.png', link: 'https://remiapp.ai/',
      alt_key: 'sponsors.current.remiapp' },
    { image: 'sponsors/current/kodees.png', link: 'https://www.kodees.co.ke/', alt_key: 'sponsors.current.kodees' },
    { image: 'sponsors/current/rubycon_italy.png', link: 'https://rubycon.it/',
      alt_key: 'sponsors.current.rubycon_italy' }
  ].freeze

  PREVIOUS_SPONSORS = [

    { image: 'sponsors/current/ruby_central.png', link: 'https://rubycentral.org/',
      alt_key: 'sponsors.current.ruby_central' },

    { image: 'sponsors/previous/solutech_official.svg', link: 'https://solutech.co.ke',
      alt_key: 'sponsors.current.solutech' },
    { image: 'sponsors/previous/daystar.png', link: 'https://www.daystar.ac.ke/', alt_key: 'sponsors.current.daystar' },
    { image: 'sponsors/current/prosper.png', link: 'https://www.prosperhedge.com/',
      alt_key: 'sponsors.current.prosper' },
    { image: 'sponsors/previous/gurzu.png', link: 'https://gurzu.com/', alt_key: 'sponsors.current.gurzu' }

  ].freeze

  SOCIALS = [
    {
      alt_key: 'social_media.x',
      link: 'https://x.com/ruby_african',
      icon: 'icons/x.svg',
      show: true
    },
    {
      alt_key: 'social_media.telegram',
      link: '#',
      icon: 'icons/telegram.svg',
      show: FeatureFlag.find_by(name: 'telegram')&.enabled
    },
    {
      alt_key: 'social_media.facebook',
      link: 'https://www.facebook.com/rubycommunity.africa',
      icon: 'icons/facebook.svg',
      show: true
    },
    {
      alt_key: 'social_media.instagram',
      link: 'https://www.instagram.com/africanruby_community/',
      icon: 'icons/instagram.svg',
      show: true
    },
    {
      alt_key: 'social_media.linkedin',
      link: 'https://www.linkedin.com/company/african-ruby-community/',
      icon: 'icons/linkedin.svg',
      show: true
    },
    {
      alt_key: 'social_media.github',
      link: 'https://github.com/African-Ruby-Community/arc_platform',
      icon: 'icons/github.svg',
      show: true
    }
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

  # Returns the country map icon path for a given country name
  # Only returns path if the icon file actually exists
  # rubocop:disable Metrics/MethodLength
  def country_icon(country_name)
    return nil if country_name.blank?

    # Map of countries with actual icon files
    icon_map = {
      'Algeria' => 'countries/country_algeria.png',
      'Angola' => 'countries/country_angola.png',
      'Benin' => 'countries/country_benin.png',
      'Botswana' => 'countries/country_botswana.png',
      'Burkina Faso' => 'countries/country_burkina_faso.png',
      'Burundi' => 'countries/country_burundi.png',
      'Cape Verde' => 'countries/country_cape_verde.png',
      'Cameroon' => 'countries/country_cameroon.png',
      'Central African Republic' => 'countries/country_central_african_republic.png',
      'Chad' => 'countries/country_chad.png',
      'Comoros' => 'countries/country_comoros.png',
      'Congo' => 'countries/congo.png',
      'DR Congo' => 'countries/country_democratic_republic_of_congo.png',
      'Djibouti' => 'countries/country_djibouti.png',
      'Egypt' => 'countries/country_egypt.png',
      'Equatorial Guinea' => 'countries/country_equatorial_guinea.png',
      'Eritrea' => 'countries/country_eritrea.png',
      'Eswatini' => 'countries/country_eswatini.png',
      'Ethiopia' => 'countries/country_ethiopia.png',
      'Gabon' => 'countries/country_gabon.png',
      'Gambia' => 'countries/country_gambia.png',
      'Ghana' => 'countries/country_ghana.png',
      'Guinea' => 'countries/country_guinea.png',
      'Guinea-Bissau' => 'countries/country_guinea_bissau.png',
      'Ivory Coast' => 'countries/country_ivory_coast.png',
      'Kenya' => 'countries/country_kenya.png',
      'Lesotho' => 'countries/country_lesotho.png',
      'Liberia' => 'countries/country_liberia.png',
      'Libya' => 'countries/country_libya.png',
      'Madagascar' => 'countries/country_madagascar.png',
      'Mali' => 'countries/country_mali.png',
      'Malawi' => 'countries/country_malawi.png',
      'Mauritania' => 'countries/country_mauritania.png',
      'Mauritius' => 'countries/country_mauritius.png',
      'Morocco' => 'countries/country_morocco.png',
      'Mozambique' => 'countries/country_mozambique.png',
      'Namibia' => 'countries/country_namibia.png',
      'Niger' => 'countries/country_niger.png',
      'Nigeria' => 'countries/country_nigeria.png',
      'Rwanda' => 'countries/country_rwanda.png',
      'Sao Tome & Principe' => 'countries/country_sao_tome_and_principe.png',
      'Senegal' => 'countries/country_senegal.png',
      'Seychelles' => 'countries/country_seychelles.png',
      'Sierra Leone' => 'countries/country_sierra_leone.png',
      'Somalia' => 'countries/country_somalia.png',
      'South Africa' => 'countries/country_south_africa.png',
      'South Sudan' => 'countries/country_south_sudan.png',
      'Sudan' => 'countries/country_sudan.png',
      'Tanzania' => 'countries/country_tanzania.png',
      'Togo' => 'countries/country_togo.png',
      'Tunisia' => 'countries/country_tunisia.png',
      'Uganda' => 'countries/country_uganda.png',
      'Zambia' => 'countries/country_zambia.png',
      'Zimbabwe' => 'countries/country_zimbabwe.png'
    }

    icon_map[country_name]
  end

  # rubocop:enable Metrics/MethodLength
end
# rubocop:enable Metrics/ModuleLength
