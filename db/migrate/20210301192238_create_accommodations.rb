class CreateAccommodations < ActiveRecord::Migration[6.1]
  def change
    create_table :accommodations do |t|
      t.string :name
      t.references :host, null: false, foreign_key: true
      t.integer :price_per_night

      t.timestamps
    end
  end
end
