class AddFieldsToSong < ActiveRecord::Migration[7.0]
  def change
    add_column :songs, :artist,   :string
    add_column :songs, :key,      :string
    add_column :songs, :duration, :integer

    add_column :songs, :chords, :text
  end
end
