class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :guest, null: false, foreign_key: true
      t.references :accommodation, null: false, foreign_key: true
      t.string :name
      t.datetime :check_in
      t.datetime :check_out
      t.integer :status
      t.integer :total_guests

      t.timestamps
    end
  end
end
