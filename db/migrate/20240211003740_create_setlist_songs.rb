class CreateSetlistSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :setlist_songs do |t|
      t.references :setlist, null: false, foreign_key: true
      t.references :song, null: false, foreign_key: true
      t.integer :display_sort

      t.timestamps
    end
  end
end
