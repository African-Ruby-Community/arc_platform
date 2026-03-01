# frozen_string_literal: true

module ChaptersHelper
  ACTIVITIES = [
    {
      image: 'activities_local_meetups.png',
      title: 'Local Meetups',
      description: 'Monthly gatherings in cities across East Africa where developers share knowledge and network.',
      svg_paths: '<path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>'
    },
    {
      image: 'activities_local_conferences.png',
      title: 'Conferences',
      description: 'RubyConf Africa brings together the best minds in the Ruby ecosystem for talks, workshops, and collaboration.',
      svg_paths: '<path d="M2 3h20"/><path d="M21 3v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V3"/><path d="m7 21 5-5 5 5"/>'
    },
    {
      image: 'activities_local_programming.png',
      title: 'Programming',
      description: 'Collaborative coding sessions, pair programming, and open-source contributions to the global Ruby ecosystem.',
      svg_paths: '<path d="m18 16 4-4-4-4"/><path d="m6 8-4 4 4 4"/><path d="m14.5 4-5 16"/>'
    },
    {
      image: 'activities_local_workshops.png',
      title: 'Workshops',
      description: 'Hands-on workshops for all skill levels, from Ruby fundamentals to advanced Rails development.',
      svg_paths: '<path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"/>'
    },
    {
      image: 'activities_local_hackathons.png',
      title: 'Hackathons',
      description: 'Competitive hackathons challenging developers to build innovative solutions using Ruby technologies.',
      svg_paths: '<path d="M6 9H4.5a2.5 2.5 0 0 1 0-5H6"/><path d="M18 9h1.5a2.5 2.5 0 0 0 0-5H18"/><path d="M4 22h16"/><path d="M10 14.66V17c0 .55-.47.98-.97 1.21C7.85 18.75 7 20.24 7 22"/><path d="M14 14.66V17c0 .55.47.98.97 1.21C16.15 18.75 17 20.24 17 22"/><path d="M18 2H6v7a6 6 0 0 0 12 0V2Z"/>'
    }
  ].freeze

  CHAPTERS = [
    {
      country: 'Kenya',
      community: 'Nairuby (ARC Nairobi)',
      location: 'Nairobi, Kenya',
      members: '2,000+',
      description: 'Our largest and flagship chapter, hosting weekly meetups and leading community initiatives across Kenya.',
      meetup_frequency: 'Weekly on Wednesdays',
      image: 'country_kenya.png',
      alt: 'Nairuby'
    },
    {
      country: 'Uganda',
      community: 'ARC Kampala',
      location: 'Kampala, Uganda',
      members: '800+',
      description: 'A vibrant community of developers fostering Ruby adoption and entrepreneurship in Uganda.',
      meetup_frequency: 'Bi-weekly meetups',
      image: 'country_uganda.png',
      alt: 'ARC Uganda'
    },
    {
      country: 'Rwanda',
      community: 'ARC Kigali',
      location: 'Kigali, Rwanda',
      members: '600+',
      description: 'Growing community connecting developers across Rwanda and promoting Ruby skills.',
      meetup_frequency: 'Monthly meetups',
      image: 'country_rwanda.png',
      alt: 'ARC Rwanda'
    },
    {
      country: 'Tanzania',
      community: 'ARC Dar es Salaam',
      location: 'Dar es Salaam, Tanzania',
      members: '500+',
      description: 'Building the developer community and tech ecosystem in Tanzania\'s commercial hub.',
      meetup_frequency: 'Monthly meetups',
      image: 'country_tanzania.png',
      alt: 'ARC Tanzania'
    }
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

  PROJECTS = [
    {
      title: 'Nairuby Website',
      description: 'The official Nairuby chapter website showcasing events and community resources.',
      tags: ['Ruby', 'Rails', 'Community'],
      stars: '240',
      github_url: 'https://github.com/nairuby',
      url: '#'
    },
    {
      title: 'ARC Learning Platform',
      description: 'An open-source platform for sharing Ruby learning resources and tutorials.',
      tags: ['Ruby', 'Education', 'Open Source'],
      stars: '189',
      github_url: 'https://github.com/nairuby',
      url: '#'
    },
    {
      title: 'Ruby Dev Tools',
      description: 'A collection of developer tools built by the community to improve Ruby workflows.',
      tags: ['Ruby', 'Tools', 'Utilities'],
      stars: '156',
      github_url: 'https://github.com/nairuby',
      url: '#'
    },
    {
      title: 'Community Contribution Guide',
      description: 'Comprehensive guide to contributing to Ruby projects and open source.',
      tags: ['Documentation', 'Open Source'],
      stars: '312',
      github_url: 'https://github.com/nairuby',
      url: '#'
    },
    {
      title: 'ARC Conference App',
      description: 'Mobile-first app for our annual Ruby Conference with schedule and networking features.',
      tags: ['Ruby', 'Rails', 'Events'],
      stars: '98',
      github_url: 'https://github.com/nairuby',
      url: '#'
    },
    {
      title: 'Ruby Best Practices',
      description: 'A curated collection of Ruby best practices and design patterns from community experts.',
      tags: ['Ruby', 'Best Practices', 'Guide'],
      stars: '467',
      github_url: 'https://github.com/nairuby',
      url: '#'
    }
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
    ACTIVITIES
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

  def static_projects
    PROJECTS
  end

  def socials
    SOCIALS.map do |social|
      social.merge(alt: I18n.t(social[:alt_key]))
    end
  end
end
