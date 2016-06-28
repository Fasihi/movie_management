class Movie < ActiveRecord::Base
  def display_description
    self.description.to_s.html_safe
  end

  def display_trailer
    self.trailer.to_s.html_safe
  end
end
