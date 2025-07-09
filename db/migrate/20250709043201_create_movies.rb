class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :sinopsis
      t.string :trailer_url
      t.string :thumbnail_url
      t.integer :duration_secs
      t.references :genre, null: false, foreign_key: true
      t.boolean :is_featured
      t.datetime :published_at

      t.timestamps
    end
  end
end
