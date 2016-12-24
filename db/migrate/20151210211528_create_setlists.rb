class CreateSetlists < ActiveRecord::Migration
  def change
    create_table :setlists do |t|
      t.references :band, index: true, foreign_key: true
      t.string :name
      t.date :date
      t.text :notes

      t.timestamps null: false
    end
  end
end
