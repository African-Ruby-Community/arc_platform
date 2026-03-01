# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Sample learning materials for Rails & Ruby
if defined?(LearningMaterial)
  LearningMaterial.find_or_create_by!(title: 'Rails Guides') do |lm|
    lm.level = :beginner
    lm.thumbnail = 'https://rubyonrails.org/images/rails-logo.svg'
    lm.link = 'https://guides.rubyonrails.org/'
    lm.featured = true
    lm.description = 'Official Rails Guides for beginners to experts.'
  end

  LearningMaterial.find_or_create_by!(title: 'Ruby Official') do |lm|
    lm.level = :intermediate
    lm.thumbnail = 'https://www.ruby-lang.org/images/header-ruby-logo.png'
    lm.link = 'https://www.ruby-lang.org/en/documentation/'
    lm.featured = false
    lm.description = 'Official Ruby documentation and resources.'
  end
end

# Seed Projects
if defined?(Project)
  Rails.logger.debug 'Seeding Projects...'

  # Ensure we have a country and chapter
  country = Country.find_or_create_by!(name: 'Kenya')
  chapter = Chapter.find_or_create_by!(name: 'Nairobi') do |c|
    c.location = 'Nairobi, Kenya'
    c.description = 'The Nairobi chapter of the African Ruby Community.'
    c.country = country
  end

  # Create Featured Project
  Project.find_or_create_by!(name: 'ARC Platform') do |p|
    p.description = 'The official platform for the African Ruby Community.'
    p.intro = 'Connecting Ruby developers across Africa'
    p.chapter = chapter
    p.owner_name = 'ARC Team'
    p.featured = true
    p.featured_order = 1
    p.preview_link = 'https://arc.codes'
    p.git_link = 'https://github.com/African-Ruby-Community/arc_platform'
    p.start_date = Date.new(2023, 1, 1)
  end

  # Create Standard Projects
  project_data = [
    {
      name: 'RubyPay',
      intro: 'Seamless payments for African businesses',
      description: 'A Ruby gem that integrates with major African payment gateways like M-Pesa, Paystack, and Pesapal.',
      owner: 'Juma Githinji',
      git: 'https://github.com/example/rubypay',
      preview_link: 'https://rubycommunity.africa'
    },
    {
      name: 'Savannah HR',
      intro: 'HR management for remote teams',
      description: 'An open-source HR management system designed for remote-first companies in Africa.',
      owner: 'Sarah Elchapo',
      git: 'https://github.com/example/savannah-hr',
      preview_link: 'https://rubycommunity.africa'
    },
    {
      name: 'AgriTech Connect',
      intro: 'Connecting farmers to markets',
      description: 'A mobile-friendly web application that helps small-scale farmers connect directly with buyers.',
      owner: 'David Ochieng',
      git: 'https://github.com/example/agritech',
      preview_link: 'https://rubycommunity.africa'
    },
    {
      name: 'EduTrack',
      intro: 'School management system',
      description: 'Comprehensive school management software for primary and secondary schools.',
      owner: 'Grace Muthoni',
      git: 'https://github.com/example/edutrack',
      preview_link: 'https://rubycommunity.africa'
    },
    {
      name: 'HealthLink',
      intro: 'Telemedicine platform',
      description: 'Connects patients with doctors for virtual consultations.',
      owner: 'Samuel Kimani',
      git: 'https://github.com/example/healthlink',
      preview_link: 'https://rubycommunity.africa'
    },
    {
      name: 'LogiMove',
      intro: 'Logistics and delivery tracking',
      description: 'Real-time tracking solution for logistics companies.',
      owner: 'Brian Kipkorir',
      git: 'https://github.com/example/logimove',
      preview_link: 'https://rubycommunity.africa'
    },
    {
      name: 'EstateManager',
      intro: 'Real estate property management',
      description: 'Helps landlords and property managers track rent payments, maintenance requests, tenant leases.',
      owner: 'Faith Chebet',
      git: 'https://github.com/example/estatemanager',
      preview_link: 'https://rubycommunity.africa'
    },
    {
      name: 'EventHub',
      intro: 'Discover local tech events',
      description: 'A platform to discover and register for technology conferences, meetups, and workshops happening.',
      owner: 'Kevin Maina',
      git: 'https://github.com/example/eventhub',
      preview_link: 'https://rubycommunity.africa'
    },
    {
      name: 'CharityFlow',
      intro: 'Donation tracking for NGOs',
      description: 'Transparency tool for NGOs to track incoming donations and outgoing project expenses.',
      owner: 'Mercy Chebet',
      git: 'https://github.com/example/charityflow',
      preview_link: 'https://rubycommunity.africa'
    },
    {
      name: 'JobFinder',
      intro: 'Tech jobs in Africa',
      description: 'A curated job board for software engineering roles across Africa.',
      owner: 'Paul Amiro',
      git: 'https://github.com/example/jobfinder',
      preview_link: 'https://rubycommunity.africa'
    }
  ]

  project_data.each_with_index do |data, index|
    Project.find_or_create_by!(name: data[:name]) do |p|
      p.description = data[:description]
      p.intro = data[:intro]
      p.chapter = chapter
      p.owner_name = data[:owner]
      p.featured = false
      p.git_link = data[:git]
      p.start_date = Time.zone.today - (index * 30).days
    end
  end

  Rails.logger.debug { "Seeded #{Project.count} projects." }
end
