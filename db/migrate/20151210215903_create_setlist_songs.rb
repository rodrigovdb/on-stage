class CreateSetlistSongs < ActiveRecord::Migration
  def change
    create_table :setlist_songs do |t|
      t.references :setlist, index: true, foreign_key: true
      t.references :song, index: true, foreign_key: true
      t.integer :order

      t.timestamps null: false
    end
  end
end
