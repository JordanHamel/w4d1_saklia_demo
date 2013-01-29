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