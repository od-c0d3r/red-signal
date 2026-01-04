class Event < ApplicationRecord
  validates :longitude, :latitude, :briefing, :title, presence: true
end
