class Customer < ActiveRecord::Base
  set_table_name(:customer)
  set_primary_key(:customer_id)

  has_many :rentals
  has_many :inventories, through: :rentals
  has_many :films, through: :inventories
  has_many :categories, through: :films

  def self.avid_watchers
    self
      .select("customer.*, COUNT(*) AS watched_movie_count")
      .joins(:films)
      .group("customer.customer_id")
      .order("watched_movie_count DESC")
      .limit(10)
  end

  def films_per_category
    self.categories
      .select("category.*, COUNT(*) AS movies_in_category")
      .group("category.category_id")
      .order("movies_in_category DESC")
  end
end