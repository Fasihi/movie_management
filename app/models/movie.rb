class Movie < ActiveRecord::Base

  def display_description
    self.description.to_s.html_safe
  end

  def display_trailer
    self.trailer.to_s.html_safe
  end

  def display_actors
    self.actors.pluck(:name).join(', ')
  end

  def display_duration
    seconds = duration * 60
    Time.at(seconds).utc.strftime("%H:%M:%S")
  end

  has_many :attachments, as: :attachable
  has_many :roles
  has_many :actors, through: :roles
  accepts_nested_attributes_for :attachments, allow_destroy: true
end
