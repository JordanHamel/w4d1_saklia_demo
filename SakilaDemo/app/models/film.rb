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
end