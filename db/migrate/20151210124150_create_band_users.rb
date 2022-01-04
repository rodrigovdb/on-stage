class CreateBandUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :band_users do |t|
      t.references :band, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
