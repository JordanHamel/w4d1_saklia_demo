class Category < ActiveRecord::Base
  set_table_name(:category)
  set_primary_key(:category_id)

  has_many :film_categories
  has_many :films, through: :film_categories
  has_many :actors, through: :films
  has_many :rentals, through: :films

  def self.most_popular
    self
      .select("category.*, COUNT(*) AS num_films")
      .joins(:films)
      .group("category.category_id")
      .order("num_films DESC")
      .limit(10)
  end

  def self.most_rented
    self
      .select("category.*, COUNT(DISTINCT rental.rental_id) AS rental_count")
      .joins(:rentals)
      .group("category.category_id")
      .order("rental_count DESC")
      .limit(10)
  end
end