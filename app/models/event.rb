class Event < ApplicationRecord
  belongs_to :chapter
  
  # payment status 
  enum cost: { free:0, paid: 1}
end
