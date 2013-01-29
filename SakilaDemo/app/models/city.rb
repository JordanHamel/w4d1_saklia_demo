class City < ActiveRecord::Base
  set_table_name(:city)
  set_primary_key(:city_id)

  belongs_to :country

  # def self.rentals_per_city
  #   self
  #     .select("city.*, COUNT(*) AS rental_count")
  #     .joins("address ON city.city_id = address.city_id")
  #     .joins("store ON address.address_id = store.address_id")
  #     .joins("JOIN inventory ON store.store_id = inventory.store_id")
  #     .joins("rental ON inventory.inventory_id = rental.inventory_id")
  #     .group("city.city_id")
  #     .order("rental_count DESC")
  # end
end

rentals per city
  SELECT city.*, COUNT(*) AS rental_count
    FROM city
    JOIN address ON city.city_id = address.city_id
    JOIN store ON address.address_id = store.address_id
    JOIN inventory ON store.store_id = inventory.store_id
    JOIN rental ON inventory.inventory_id = rental.inventory_id
    GROUP BY city.city_id
    ORDER BY rental_count DESC