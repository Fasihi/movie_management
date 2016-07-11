class Movie < ActiveRecord::Base
  has_many :posters, class_name: "Attachment", as: :attachable, dependent: :destroy
  has_many :roles
  has_many :actors, through: :roles, dependent: :destroy

  accepts_nested_attributes_for :posters, allow_destroy: true
  validates :title, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :genre, presence: true, length: { maximum: 15 }
  validates :trailer, presence: true
  validates :description, presence: true

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
    seconds = duration.to_i * 60
    Time.at(seconds).utc.strftime("%H:%M:%S")
  end

  def first_poster
    poster = posters.first
    poster ? poster.try(:image).url(:medium) : 'medium/default_poster.jpg'
  end

end
