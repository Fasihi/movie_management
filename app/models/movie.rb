class Movie < ActiveRecord::Base

  def display_description
    self.description.to_s.html_safe
  end

  def display_trailer
    self.trailer.to_s.html_safe
  end

  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments, allow_destroy: true
end
