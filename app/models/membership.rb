class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :chapter

  # action_cable & turbo_stream for live updates
  after_create_commit -> {
    broadcast_prepend_to 'memberships', partial: 'memberships/membership',
     locals: {membership: self}, target: 'memberships' }
end
