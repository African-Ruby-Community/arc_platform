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

  # Ensure we have countries - all countries with icon files
  countries_data = [
    'Algeria', 'Angola', 'Benin', 'Botswana', 'Burkina Faso', 'Burundi',
    'Cameroon', 'Central African Republic', 'Chad', 'Democratic Republic of Congo',
    'Egypt', 'Ethiopia', 'Gabon', 'Ghana', 'Ivory Coast', 'Kenya',
    'Madagascar', 'Malawi', 'Mauritius', 'Morocco', 'Namibia', 'Nigeria',
    'Rwanda', 'Senegal', 'Sierra Leone', 'Somalia', 'South Africa', 'Tanzania',
    'Togo', 'Tunisia', 'Uganda', 'Zambia', 'Zimbabwe'
  ]

  countries_data.each do |country_name|
    Country.find_or_create_by!(name: country_name)
  end

  Rails.logger.debug { "Seeded #{Country.count} countries." }

  # Ensure we have a country and chapter
  country = Country.find_by(name: 'Kenya')
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

# Seed Events and Speakers
if defined?(Event) && defined?(Speaker)
  Rails.logger.debug 'Seeding Events and Speakers...'

  # Ensure we have chapters
  country = Country.find_or_create_by!(name: 'Kenya')
  nairobi_chapter = Chapter.find_or_create_by!(name: 'Nairobi') do |c|
    c.location = 'Nairobi, Kenya'
    c.description = 'The Nairobi chapter of the African Ruby Community.'
    c.country = country
  end

  mombasa_chapter = Chapter.find_or_create_by!(name: 'Mombasa') do |c|
    c.location = 'Mombasa, Kenya'
    c.description = 'The Mombasa chapter of the African Ruby Community.'
    c.country = country
  end

  # Create upcoming events
  upcoming_conference = Event.find_or_create_by!(title: 'RubyConf Africa 2025') do |e|
    e.description = 'The premier Ruby conference in Africa, bringing together developers from across the continent to share knowledge, network, and celebrate Ruby programming.'
    e.start_datetime = 3.months.from_now
    e.end_datetime = 3.months.from_now + 2.days
    e.status = 'published'
    e.event_type = 'conference'
    e.location_name = 'Kenyatta International Convention Centre, Nairobi'
    e.latitude = -1.2921
    e.longitude = 36.8219
    e.payment_status = 'paid'
    e.price_cents = 15_000
    e.chapter = nairobi_chapter
  end

  # Add speakers to the conference
  Speaker.find_or_create_by!(name: 'Matz Yukihiro', event: upcoming_conference) do |s|
    s.bio = 'Creator of the Ruby programming language. Matz has been programming since 1980 and is known for his philosophy of making programmers happy.'
  end

  Speaker.find_or_create_by!(name: 'Sarah Mei', event: upcoming_conference) do |s|
    s.bio = 'Chief Consultant at DevMynd Software and a prominent figure in the Ruby community, known for her work on improving software development practices.'
  end

  Event.find_or_create_by!(title: 'Rails Workshop for Beginners') do |e|
    e.description = 'A hands-on workshop for developers new to Ruby on Rails. Learn the fundamentals of building web applications with Rails.'
    e.start_datetime = 2.weeks.from_now
    e.end_datetime = 2.weeks.from_now + 6.hours
    e.status = 'published'
    e.event_type = 'workshop'
    e.location_name = 'iHub Nairobi'
    e.latitude = -1.2864
    e.longitude = 36.8172
    e.payment_status = 'free'
    e.price_cents = 0
    e.chapter = nairobi_chapter
  end

  Event.find_or_create_by!(title: 'Nairobi Ruby Meetup - May') do |e|
    e.description = 'Monthly meetup for Ruby developers in Nairobi. This month we will discuss performance optimization techniques and share project updates.'
    e.start_datetime = 1.month.from_now
    e.end_datetime = 1.month.from_now + 3.hours
    e.status = 'published'
    e.event_type = 'meetup'
    e.location_name = 'Nairobi Garage'
    e.latitude = -1.2921
    e.longitude = 36.8219
    e.payment_status = 'free'
    e.price_cents = 0
    e.chapter = nairobi_chapter
  end

  Event.find_or_create_by!(title: 'Mombasa Ruby Meetup') do |e|
    e.description = 'Join fellow Ruby enthusiasts in Mombasa for an evening of coding, networking, and knowledge sharing.'
    e.start_datetime = 3.weeks.from_now
    e.end_datetime = 3.weeks.from_now + 3.hours
    e.status = 'published'
    e.event_type = 'meetup'
    e.location_name = 'Swahili Pot Hub'
    e.latitude = -4.0435
    e.longitude = 39.6682
    e.payment_status = 'free'
    e.price_cents = 0
    e.chapter = mombasa_chapter
  end

  # Create past events
  past_conference = Event.find_or_create_by!(title: 'RubyConf Africa 2024') do |e|
    e.description = 'The 2024 edition of RubyConf Africa was a huge success with over 300 attendees from 15 African countries.'
    e.start_datetime = 6.months.ago
    e.end_datetime = 6.months.ago + 2.days
    e.status = 'published'
    e.event_type = 'conference'
    e.location_name = 'Kenyatta International Convention Centre, Nairobi'
    e.latitude = -1.2921
    e.longitude = 36.8219
    e.payment_status = 'paid'
    e.price_cents = 12_000
    e.chapter = nairobi_chapter
  end

  Speaker.find_or_create_by!(name: 'DHH', event: past_conference) do |s|
    s.bio = 'Creator of Ruby on Rails and founder of Basecamp. DHH is a strong advocate for programmer happiness and work-life balance.'
  end

  Event.find_or_create_by!(title: 'Nairobi Ruby Meetup - January') do |e|
    e.description = 'Our first meetup of 2024 focused on new features in Rails 7.1 and community project showcases.'
    e.start_datetime = 4.months.ago
    e.end_datetime = 4.months.ago + 3.hours
    e.status = 'published'
    e.event_type = 'meetup'
    e.location_name = 'Nairobi Garage'
    e.latitude = -1.2921
    e.longitude = 36.8219
    e.payment_status = 'free'
    e.price_cents = 0
    e.chapter = nairobi_chapter
  end

  Rails.logger.debug { "Seeded #{Event.count} events and #{Speaker.count} speakers." }
end

# Enable feature flags for events, conferences, projects, and learning materials
if defined?(FeatureFlag)
  FeatureFlag.find_or_create_by!(name: 'events') do |ff|
    ff.enabled = true
    ff.description = 'Show/hide Events in navigation'
  end

  FeatureFlag.find_or_create_by!(name: 'conferences') do |ff|
    ff.enabled = true
    ff.description = 'Show/hide Conferences in navigation'
  end

  FeatureFlag.find_or_create_by!(name: 'projects') do |ff|
    ff.enabled = true
    ff.description = 'Show/hide Projects in navigation'
  end

  FeatureFlag.find_or_create_by!(name: 'learning_materials') do |ff|
    ff.enabled = true
    ff.description = 'Show/hide Learning Materials in navigation'
  end

  Rails.logger.debug 'Enabled events, conferences, projects, and learning materials feature flags.'
end

# Create admin user
if defined?(User)
  # Organization Admin
  admin_user = User.find_or_initialize_by(email: 'admin@example.com')

  if admin_user.new_record?
    admin_user.name = 'Admin User'
    admin_user.password = 'password'
    admin_user.password_confirmation = 'password'
    admin_user.role = :organization_admin
    admin_user.confirmed_at = Time.current # Skip email confirmation
    admin_user.skip_github_verification = true

    if admin_user.save
      Rails.logger.debug 'Created admin user: admin@example.com with password: password'
    else
      Rails.logger.error "Failed to create admin user: #{admin_user.errors.full_messages.join(', ')}"
    end
  else
    Rails.logger.debug 'Admin user already exists: admin@example.com'
  end

  # Chapter Admin for Nairobi
  nairobi_admin = User.find_or_initialize_by(email: 'nairobi.admin@example.com')

  if nairobi_admin.new_record?
    nairobi_admin.name = 'Nairobi Chapter Admin'
    nairobi_admin.password = 'password'
    nairobi_admin.password_confirmation = 'password'
    nairobi_admin.role = :chapter_admin
    nairobi_admin.confirmed_at = Time.current
    nairobi_admin.skip_github_verification = true

    if nairobi_admin.save
      associate_user_with_chapter(nairobi_admin, 'Nairobi')
      Rails.logger.debug 'Created chapter admin: nairobi.admin@example.com with password: password'
    else
      Rails.logger.error "Failed to create chapter admin: #{nairobi_admin.errors.full_messages.join(', ')}"
    end
  else
    Rails.logger.debug 'Nairobi chapter admin already exists: nairobi.admin@example.com'
  end

  # Chapter Admin for Mombasa
  mombasa_admin = User.find_or_initialize_by(email: 'mombasa.admin@example.com')

  if mombasa_admin.new_record?
    mombasa_admin.name = 'Mombasa Chapter Admin'
    mombasa_admin.password = 'password'
    mombasa_admin.password_confirmation = 'password'
    mombasa_admin.role = :chapter_admin
    mombasa_admin.confirmed_at = Time.current
    mombasa_admin.skip_github_verification = true

    if mombasa_admin.save
      associate_user_with_chapter(mombasa_admin, 'Mombasa')
      Rails.logger.debug 'Created chapter admin: mombasa.admin@example.com with password: password'
    else
      Rails.logger.error "Failed to create chapter admin: #{mombasa_admin.errors.full_messages.join(', ')}"
    end
  else
    Rails.logger.debug 'Mombasa chapter admin already exists: mombasa.admin@example.com'
  end

  # Regular Members
  member_data = [
    { email: 'john.doe@example.com', name: 'John Doe', chapter: 'Nairobi' },
    { email: 'jane.smith@example.com', name: 'Jane Smith', chapter: 'Nairobi' },
    { email: 'peter.kamau@example.com', name: 'Peter Kamau', chapter: 'Mombasa' },
    { email: 'mary.wanjiku@example.com', name: 'Mary Wanjiku', chapter: 'Nairobi' },
    { email: 'david.omondi@example.com', name: 'David Omondi', chapter: 'Mombasa' }
  ]

  member_data.each do |data|
    member = User.find_or_initialize_by(email: data[:email])

    if member.new_record?
      member.name = data[:name]
      member.password = 'password'
      member.password_confirmation = 'password'
      member.role = :member
      member.confirmed_at = Time.current
      member.skip_github_verification = true

      if member.save
        associate_user_with_chapter(member, data[:chapter])
        Rails.logger.debug { "Created member: #{data[:email]} with password: password" }
      else
        Rails.logger.error "Failed to create member #{data[:email]}: #{member.errors.full_messages.join(', ')}"
      end
    else
      Rails.logger.debug { "Member already exists: #{data[:email]}" }
    end
  end

  Rails.logger.debug { "Seeded #{User.count} users total." }
end

# Helper method to associate user with chapter
def associate_user_with_chapter(user, chapter_name)
  return unless defined?(Chapter)

  chapter = Chapter.find_by(name: chapter_name)
  return unless chapter

  UsersChapter.find_or_create_by!(user: user, chapter: chapter) do |uc|
    uc.main_chapter = true
  end
end
