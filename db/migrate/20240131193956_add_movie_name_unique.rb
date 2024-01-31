class AddMovieNameUnique < ActiveRecord::Migration[6.1]
  def change
    add_index :movies, ["name"], unique: true, name: "index_movies_on_name"
  end
end
