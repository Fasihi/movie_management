class Movie < ActiveRecord::Base
  include ThinkingSphinx::Scopes

  paginates_per 8
  SEARCH_PER_PAGE = 8
  DEFAULT_SEARCH_FILTER = { approved: true }
  DEFAULT_SEARCH_ORDER = 'updated_at DESC'

  has_many :posters, class_name: "Attachment", as: :attachable, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :actors, through: :roles, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favorite_movies, dependent: :destroy

  accepts_nested_attributes_for :posters, allow_destroy: true, reject_if: proc { |attributes| attributes['image'].blank? }
  validates :title, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :genre, presence: true, length: { maximum: 15 }
  validates :trailer, presence: true, length: { maximum: 2000 }
  validates :description, presence: true

  scope :latest_movies, -> { order("release_date DESC") }
  scope :featured_movies, -> { where(featured: true) }
  scope :top_movies, -> { joins(:ratings).group('movie_id').order('AVG(ratings.score) DESC') }
  scope :sort, -> { order('release_date DESC') }
  scope :approved, -> { where(approved: true).sort }

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

  def self.get_movies(filter)
    movie = Movie.includes(:posters)
    if filter == "latest"
      movie.latest_movies.approved
    elsif filter == "featured"
      movie.featured_movies.approved
    elsif filter == "top"
      movie.top_movies.approved
    else
      movie.all.approved
    end
  end

  def get_average
    self.ratings.present? ? self.ratings.average(:score) : 0
  end

  def get_ratings(user)
    user.ratings.for_movie(self).first || user.ratings.build(movie: self)
  end

  def favorite_of?(user)
    user.favorite_movies.include? self
  end

  def details_hash
    {
      id: id,
      title: title,
      release_date: release_date,
      genre: genre,
      description: description,
      actors: actors.pluck(:id, :name, :biography, :gender, :created_at, :updated_at),
      reviews: reviews.pluck(:id, :user_id, :comment, :created_at, :updated_at, :report_count),
      ratings: ratings.pluck(:id, :score, :created_at, :updated_at, :user_id),
    }
  end

  def self.search_movie(params)
    conditions = {
      title: params[:title],
      genre: params[:genre],
      actors: params[:actors],
      release_date: params[:release_date]
    }

    Movie.search(conditions: conditions, with: DEFAULT_SEARCH_FILTER, order: DEFAULT_SEARCH_ORDER)
  end

  def self.search_movies(params)
    if(params[:filter])
      get_movies(params[:filter])
    else
      conditions =  {
                      conditions: {},
                      with: {},
                      order: 'release_date DESC',
                    }

      conditions[:conditions][:genre] = params[:genre] if params[:genre].present?
      conditions[:conditions][:actors] = params[:actors] if params[:actors].present?
      conditions[:with][:release_date] = date_range(params[:start_date], params[:end_date]) if params[:start_date].present?
      conditions[:with][:approved] = true

      self.search params[:search], conditions
    end
  end

  def self.date_range(start_date, end_date)
    if start_date.present? && end_date.present?
      Date.parse(start_date)..Date.parse(end_date)
    elsif start_date.present?
      Date.parse(start_date)..Date.today
    end
  end
end
