class Film < ActiveRecord::Base
  set_table_name(:film)
  set_primary_key(:film_id)

  has_many :contracts, class_name: "FilmActor"
  has_many :actors, through: :contracts
  has_many :genres, class_name: "FilmCategory"
  has_many :categories, through: :genres

  has_many :inventories
  has_many :stores, through: :inventories
  has_many :customers, through: :inventories
  has_many :rentals, through: :customers


  def self.biggest_cast
    self
      .select("film.*, COUNT(*) AS cast_count")
      .joins(:contracts)
      .group("film.film_id")
      .order("cast_count DESC")
      .limit(10)
  end

  def self.most_stores
    self
      .select("film.*, COUNT(*) AS store_count")
      .joins(:stores)
      .group("film.film_id")
      .order("store_count DESC")
      .first
  end

  def self.most_inventory
    self
      .select("film.*, COUNT(*) AS inventory_count")
      .joins(:inventories)
      .group("film.film_id")
      .order("inventory_count DESC")
      .first
  end

  def self.most_watched
    self
      .select("film.*, COUNT(*) AS rental_count")
      .joins(:rentals)
      .group("film.film_id")
      .order("rental_count DESC")
      .limit(10)
  end

  def self.gross_movies
    movie_grosses = self
      .select("film.film_id, film.rental_rate * COUNT(DISTINCT
        rental.rental_id) AS gross_per_movie")
      .joins(:rentals)
      .group("film.film_id")
      .limit(10)

    gross_sum = 0
    movie_grosses.each do |film|
      gross_sum += film.gross_per_movie.to_f
    end

    gross_sum
  end

  def gross
     self.rentals.count * self.rental_rate.to_f
  end
end










