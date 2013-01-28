class Rental < ActiveRecord::Base
  set_table_name(:rental)
  set_primary_key(:rental_id)

  belongs_to :inventory
  belongs_to :customer
end