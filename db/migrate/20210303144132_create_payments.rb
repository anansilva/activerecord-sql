class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.integer :status
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
