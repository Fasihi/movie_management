module MoviesHelper
  def display_date(date)
    if date.present?
      date_array = date.to_s.split('-')
      [date_array[1], date_array[2], date_array[0]].join('-')
    end
  end
end
