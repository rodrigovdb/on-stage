# frozen_string_literal: true

class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.references :band, null: false, foreign_key: true
      t.string :name, null: false
      t.string :artist, null: false
      t.string :key
      t.integer :duration
      t.text :chords

      t.timestamps
    end
  end
end
