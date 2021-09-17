class CreateRentals < ActiveRecord::Migration[6.1]
  def change
    create_table :rentals do |t|
      t.string :rental_number
      t.decimal :rent_amount
      t.string :status

      t.timestamps
    end
  end
end
