class Actor < ActiveRecord::Base
  set_table_name(:actor)
  set_primary_key(:actor_id)

  has_many :roles, class_name: "FilmActor"
  has_many :films, through: :roles
  has_many :categories, through: :films
  has_many :stores, through: :films
  has_many :countries, through: :stores
  has_many :rentals, through: :films

  def self.most_films
    self
      .select("actor.*, COUNT(*) AS film_count")
      .joins(:roles)
      .group("actor.actor_id")
      .order("film_count DESC")
      .limit(10)
  end

  def avg_gross
    total_gross = 0
    num_movies = 0

    self.films.each do |film|
      total_gross += film.gross
      num_movies += 1
    end

    total_gross / num_movies
  end

  def self.avg_gross
    self
      .select("actor.*, AVG((film.rental_rate * COUNT(DISTINCT rental.rental_id))) AS actor_avg")
      .joins(:films)
      .joins(:rentals)
      .group("actor.actor_id")
      .order("actor_avg DESC")













    # actors_with_film = self.includes(:films)

    # actors_with_film.each do |actor|
    #   total_gross = 0
    #   num_movies = 0
    #   actor.films.each do |film|
    #     total_gross += film.gross
    #     num_movies += 1
    #   end

  end

  # def self.most_popular(country)
  #   self
  #     .select("actor.*, COUNT(*) AS rental_count")
  #     .joins(:rentals)
  #     .where()

  # end

  # self
  #   .includes(:rentals).includes(:city)
end

# most popular actor in country by num rentals
# SELECT actor.*, COUNT(*) AS rental_count
# FROM actor
# .join(:renta)