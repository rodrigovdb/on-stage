class CreateSetlistSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :setlist_songs do |t|
      t.references :setlist, index: true, foreign_key: true
      t.references :song, index: true, foreign_key: true
      t.integer :display_sort

      t.timestamps null: false
    end
  end
end
