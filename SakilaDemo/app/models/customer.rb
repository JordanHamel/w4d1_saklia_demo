class Customer < ActiveRecord::Base
  set_table_name(:customer)
  set_primary_key(:customer_id)

  has_many :rentals
  has_many :inventories, through: :rentals
  has_many :films, through: :inventories
end