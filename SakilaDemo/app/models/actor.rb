class Actor < ActiveRecord::Base
  set_table_name(:actor)
  set_primary_key(:actor_id)

  has_many :roles, class_name: "FilmActor"
  has_many :films, through: :roles
  has_many :categories, through: :films

end