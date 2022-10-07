class Event < ApplicationRecord
  belongs_to :chapter
  has_many :speakers 
  # payment status 
  enum cost: { free:0, paid: 1}
end
