class Rental < ActiveRecord::Base
  set_table_name(:rental)
  set_primary_key(:rental_id)

  belongs_to :inventory
  belongs_to :customer

  has_one :store, through: :inventory
  has_one :city, through: :store
  has_one :payment

  def self.rentals_per_city(city_id)
    self
      .select("city.*, COUNT(*) AS rental_count")
      .joins(:city)
      .where("city.id = city_id")
  end
end