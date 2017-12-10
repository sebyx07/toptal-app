class JoggingTime < ApplicationRecord
  belongs_to :user
  before_save :_set_average_speed
  def _set_average_speed
    self.average_speed = ((self.distance * 1000) / (self.time * 60)).round(2)
  end
end
