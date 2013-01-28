class FilmActor < ActiveRecord::Base
  set_table_name(:film_actor)

  belongs_to :actor
  belongs_to :film
end