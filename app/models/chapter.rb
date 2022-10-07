class Chapter < ApplicationRecord
  belongs_to :country
  has_many :projects 
  has_many :events 
end
