# frozen_string_literal: true

class CreateBandUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :band_users do |t|
      t.references :band, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role, null: false, default: 'mate'

      t.timestamps
    end
  end
end
