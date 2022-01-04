class CreateBands < ActiveRecord::Migration[7.0]
  def change
    create_table :bands do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
